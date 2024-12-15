import cocotb
from cocotb.triggers import Timer, RisingEdge, FallingEdge
from cocotb.clock import Clock
from cocotb.binary import BinaryValue
import random
from cocotb.regression import TestFactory

class FIFOTest:
    def __init__(self, dut):
        self.dut = dut
        self.WIDTH = 4  # Matches parameter in Verilog
        self.DEPTH = 8  # Matches parameter in Verilog
        
    async def reset(self):
        """Reset the FIFO"""
        self.dut.rst_n.value = 1
        await RisingEdge(self.dut.clk)
        self.dut.rst_n.value = 0
        await RisingEdge(self.dut.clk)
        self.dut.rst_n.value = 1
        await RisingEdge(self.dut.clk)
        
    async def write_data(self, data):
        """Write data to FIFO"""
        self.dut.wr_en.value = 1
        self.dut.data_in.value = data
        await RisingEdge(self.dut.clk)
        self.dut.wr_en.value = 0
        
    async def read_data(self):
        """Read data from FIFO"""
        self.dut.rd_en.value = 1
        await RisingEdge(self.dut.clk)
        data = int(self.dut.data_out.value)
        self.dut.rd_en.value = 0
        return data

@cocotb.test()
async def test_fifo_basic(dut):
    """Test basic FIFO operations"""
    
    # Create a FIFO test instance
    fifo = FIFOTest(dut)
    
    # Start clock
    clock = Clock(dut.clk, 10, units="ns")
    cocotb.start_soon(clock.start())
    
    # Initialize signals
    dut.wr_en.value = 0
    dut.rd_en.value = 0
    dut.data_in.value = 0
    
    # Reset FIFO
    await fifo.reset()
    
    # Verify empty condition
    assert dut.empty.value == 1, "FIFO should be empty after reset"
    assert dut.full.value == 0, "FIFO should not be full after reset"
    
    # Write test pattern
    test_data = [0xA, 0xB, 0xC, 0xD]
    for data in test_data:
        await fifo.write_data(data)
        
    # Verify not empty
    assert dut.empty.value == 0, "FIFO should not be empty after writes"
    
    # Read and verify data
    for expected_data in test_data:
        data = await fifo.read_data()
        assert data == expected_data, f"Read data {data} does not match expected {expected_data}"
    
    # Verify empty again
    assert dut.empty.value == 1, "FIFO should be empty after reading all data"

# @cocotb.test()
# async def test_fifo_full(dut):
#     """Test FIFO full condition"""
    
#     fifo = FIFOTest(dut)
    
#     clock = Clock(dut.clk, 10, units="ns")
#     cocotb.start_soon(clock.start())
    
#     dut.wr_en.value = 0
#     dut.rd_en.value = 0
#     dut.data_in.value = 0
    
#     await fifo.reset()
    
#     # Fill FIFO to capacity
#     for i in range(fifo.DEPTH):
#         print(i)
#         await fifo.write_data(i)
#         data = await fifo.read_data()
#         print(data)
#         #assert data == i, "First read data should be "+str(i)
        
#     # Verify full condition
#     assert dut.full.value == 1, "FIFO should be full"
    
#     # Try to write when full
#     await fifo.write_data(0xF)
#     await RisingEdge(dut.clk)
    
#     # Read one value
#     data = await fifo.read_data()
#     assert data == 0, "First read data should be 0"
    
#     # Verify no longer full
#     assert dut.full.value == 0, "FIFO should not be full after read"

# @cocotb.test()
# async def test_fifo_concurrent(dut):
#     """Test concurrent read/write operations"""
    
#     fifo = FIFOTest(dut)
    
#     clock = Clock(dut.clk, 10, units="ns")
#     cocotb.start_soon(clock.start())
    
#     dut.wr_en.value = 0
#     dut.rd_en.value = 0
#     dut.data_in.value = 0
    
#     await fifo.reset()
    
#     # Perform concurrent read/write operations
#     for i in range(16):
#         dut.wr_en.value = 1
#         dut.rd_en.value = 1
#         dut.data_in.value = i
#         await RisingEdge(dut.clk)
        
#     await RisingEdge(dut.clk)
#     dut.wr_en.value = 0
#     dut.rd_en.value = 0

if __name__ == "__main__":
    tf = TestFactory(test_fifo_basic)
    tf.generate_tests()

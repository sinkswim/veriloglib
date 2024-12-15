import cocotb
from cocotb.triggers import RisingEdge, FallingEdge
from cocotb.clock import Clock

async def waitStable(dut):
    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)

@cocotb.test()
async def test_dff(dut):
    """Test D Flip-Flop"""
    
    # Create clock
    clock = Clock(dut.clk, 10, units="ns")
    cocotb.start_soon(clock.start())
    
    # Reset
    dut.rst_n.value = 1
    dut.d.value = 0
    
    # Wait 2 clock cycles
    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)
    
    # Assert reset
    dut.rst_n.value = 0
    await RisingEdge(dut.clk)
    assert dut.q.value == 0, f"Reset failed, q = {dut.q.value}"
    
    # Deassert reset and test different values
    dut.rst_n.value = 1
    
    # Test value 1
    dut.d.value = 1
    await waitStable(dut)
    assert dut.q.value == 1, f"Failed to store 1, q = {dut.q.value}"
    
    # Test value 0
    dut.d.value = 0
    await waitStable(dut)
    assert dut.q.value == 0, f"Failed to store 0, q = {dut.q.value}"
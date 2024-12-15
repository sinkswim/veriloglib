import cocotb
from cocotb.triggers import Timer
from itertools import product

@cocotb.test()
async def test_mux21(dut):
    # Test all possible input combinations
    for a, b, sel in product([0, 1], repeat=3):
        # Set inputs
        dut.a.value = a
        dut.b.value = b
        dut.sel.value = sel
        
        # Wait for signals to propagate
        await Timer(1, units="ns")
        
        # Log all port values
        dut._log.info(f"Inputs:  a={dut.a.value}, b={dut.b.value}, sel={dut.sel.value}")
        dut._log.info(f"Output:  c={dut.c.value}")
        
        # Verify output
        expected = a if sel else b
        assert dut.c.value == expected, f"Output mismatch! Expected {expected}, got {dut.c.value}"
        
        # Add separation between test cases
        dut._log.info("-" * 40)
        
        await Timer(1, units="ns")
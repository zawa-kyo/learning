package com.example;

import org.junit.Test;
import static org.junit.Assert.*;

public class CalculatorTest {
    @Test
    public void testAdd() {
        Calculator calc = new Calculator();
        assertEquals(calc.add(1, 2), 3);
        assertEquals(calc.add(-10, 11), 1);
    }
}

# RISC-V Instruction Breakdown

15 unique RISC-V instructions

## 1. `addi sp, sp, -16`
- **Instruction Type**: I-type
- **Opcode**: `0010011`
- **Immediate**: `111111111000` (-16 in two's complement)
- **Machine Code**: `010113`
- **Purpose**: Adjust the stack pointer by subtracting 16 to allocate space on the stack.

---

## 2. `sd ra, 8(sp)`
- **Instruction Type**: S-type
- **Opcode**: `0100011`
- **Immediate**: `00000100000`
- **Machine Code**: `00113423`
- **Purpose**: Store the return address (`ra`) at memory address `sp + 8`.

---

## 3. `li a2, 5`
- **Instruction Type**: I-type
- **Opcode**: `0010011`
- **Immediate**: `000000000101` (5)
- **Machine Code**: `00500613`
- **Purpose**: Load the value `5` into register `a2`.

---

## 4. `li a1, 10`
- **Instruction Type**: I-type
- **Opcode**: `0010011`
- **Immediate**: `000000001010` (10)
- **Machine Code**: `00A00593`
- **Purpose**: Load the value `10` into register `a1`.

---

## 5. `li a0, 0x21`
- **Instruction Type**: I-type
- **Opcode**: `0010011`
- **Immediate**: `000000100001` (0x21)
- **Machine Code**: `02100513`
- **Purpose**: Load the hexadecimal value `0x21` into `a0`.

---

## 6. `addi a0, a0, 384`
- **Instruction Type**: I-type
- **Opcode**: `0010011`
- **Immediate**: `110000000` (384)
- **Machine Code**: `18050513`
- **Purpose**: Increment the value in `a0` by 384.

---

## 7. `jal ra, 0x10408`
- **Instruction Type**: J-type
- **Opcode**: `1101111`
- **Machine Code**: `26c000ef`
- **Purpose**: Jump to the address `0x10408` and store the return address in `ra`.

---

## 8. `ld ra, 8(sp)`
- **Instruction Type**: I-type
- **Opcode**: `0000011`
- **Machine Code**: `00813083`
- **Purpose**: Load a doubleword from memory location `sp + 8` into `ra`.

---

## 9. `addi sp, sp, 16`
- **Instruction Type**: I-type
- **Opcode**: `0010011`
- **Immediate**: `00000100000` (16)
- **Machine Code**: `01010113`
- **Purpose**: Increment the stack pointer by 16 to deallocate space.

---

## 10. `ret`
- **Instruction**: `jalr x0, x1, 0` (pseudo instruction for return)
- **Instruction Type**: I-type
- **Opcode**: `1100111`
- **Machine Code**: `00008067`
- **Purpose**: Return to the address stored in `ra`.

---

## 11. `mv s0, a0`
- **Instruction Type**: R-type
- **Opcode**: `0110011`
- **Machine Code**: `00050413`
- **Purpose**: Copy the value from `a0` into `s0`.

---

## 12. `beqz a5, <address>`
- **Instruction Type**: B-type
- **Opcode**: `1100011`
- **Machine Code**: `90078463`
- **Purpose**: Branch to the specified address if `a5` equals zero.

---

## 13. `auipc a5, 0x12`
- **Instruction Type**: U-type
- **Opcode**: `0010111`
- **Machine Code**: `90012797`
- **Purpose**: Compute the upper 20 bits of the program counter with `0x12`.

---

## 14. `sub a5, a5, s0`
- **Instruction Type**: R-type
- **Opcode**: `0110011`
- **Machine Code**: `408787b3`
- **Purpose**: Subtract the value in `s0` from `a5` and store the result in `a5`.

---

## 15. `jal ra, 0x12ea4`
- **Instruction Type**: J-type
- **Opcode**: `1101111`
- **Machine Code**: `4cd020ef`
- **Purpose**: Jump to the address `0x12ea4` and store the return address in `ra`.


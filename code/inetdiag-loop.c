struct inet_diag_bc_op {
    unsigned char   code; // opcode
    unsigned char   yes;  // instruction length
    unsigned short  no;   // conditional jump offset
};
const void *bc = bytecode;
while (len > 0) {
    struct inet_diag_bc_op *op = bc;
    ...
+   if (op->yes < min_len // min_len is at least 4
+       || op->yes > len + 4 || op->yes & 3)
+       return -EINVAL;
    bc += op->yes;
    len -= op->yes;
}

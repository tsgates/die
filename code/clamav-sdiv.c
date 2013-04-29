case OP_SDIV:
{
	int64_t a = BINOPS(0);
	int64_t b = BINOPS(1);
	if (b == 0 || (a == -1 && b == INT64_MIN))
		return CL_EBYTECODE;
	value->v = a / b;
	break;
}

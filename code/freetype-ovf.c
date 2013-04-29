while ( ip < limit ) {
    CFF_Operator  op = *ip++;
    FT_Fixed*  args     = decoder->top;
    // handling operator 'op', which might change args
    ...
    decoder->top = args;
+   if ( decoder->top - stack >= CFF_MAX_OPERANDS )
+     goto Stack_Overflow;
}

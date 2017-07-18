
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>

#include "murmur3.h"

CAMLprim value caml_murmur3_hash64(value data)
{
    CAMLparam1(data);
    uint64_t out[2];
    MurmurHash3_x64_128(String_val(data), caml_string_length(data), 0, &out);
    CAMLreturn(caml_copy_int64(out[0]));
}

CAMLprim value caml_murmur3_hash128(value data)
{
    CAMLparam1(data);
    CAMLlocal1(result);
    uint64_t out[2];
    MurmurHash3_x64_128(String_val(data), caml_string_length(data), 0, &out);
    result = caml_alloc_tuple(2);
    Store_field(result, 0, caml_copy_int64(out[0]));
    Store_field(result, 1, caml_copy_int64(out[1]));
    CAMLreturn(result);
}

// Copyright lowRISC contributors (OpenTitan project).
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// AUTOGENERATED. Do not edit this file by hand.
// See the crypto/tests README for details.

#ifndef OPENTITAN_SW_DEVICE_SILICON_CREATOR_LIB_SIGVERIFY_SPHINCSPLUS_TEST_SPHINCSPLUS_TESTVECTORS_H_
#define OPENTITAN_SW_DEVICE_SILICON_CREATOR_LIB_SIGVERIFY_SPHINCSPLUS_TEST_SPHINCSPLUS_TESTVECTORS_H_

#include "sw/device/silicon_creator/lib/sigverify/sphincsplus/params.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

// A test vector for SPHINCS+ signature verification.
typedef struct spx_verify_test_vector {
  uint32_t sig[kSpxVerifySigWords];  // Signature to verify.
  uint32_t pk[kSpxVerifyPkWords];    // Public key.
  size_t msg_len;                   // Length of message.
  uint8_t *msg;                     // Message.
} spx_verify_test_vector_t;

static const size_t kSpxVerifyNumTests = ${len(tests)};

// Static message arrays.
% for idx, t in enumerate(tests):
  % if t["msg_len"] == 0:
// msg${idx} is empty.
  % else:
static uint8_t msg${idx}[${t["msg_len"]}] = {
    % for i in range(0, len(t["msg_hexbytes"]), 10):
   ${', '.join(t["msg_hexbytes"][i:i + 10])},
    % endfor
};
  %endif
% endfor

static const spx_verify_test_vector_t spx_verify_tests[${len(tests)}] = {
% for idx, t in enumerate(tests):
    {
        .sig =
            {
  % for i in range(0, len(t["sig_hexwords"]), 4):
                ${', '.join(t["sig_hexwords"][i:i + 4])},
  % endfor
            },
        .pk =
            {
  % for i in range(0, len(t["pk_hexwords"]), 4):
                ${', '.join(t["pk_hexwords"][i:i + 4])},
  % endfor
            },
        .msg_len = ${t["msg_len"]},
  % if t["msg_len"] == 0:
        .msg = NULL,
  % else:
        .msg = msg${idx},
  % endif
    },
% endfor
};

#ifdef __cplusplus
}  // extern "C"
#endif  // __cplusplus

#endif // OPENTITAN_SW_DEVICE_SILICON_CREATOR_LIB_SIGVERIFY_SPHINCSPLUS_TEST_SPHINCSPLUS_TESTVECTORS_H_

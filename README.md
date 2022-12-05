# Contract with zero code size

If almost all vulnerabilites are exploited with malicious sc calls, why not allowing only Externally Owned Addresses (EOA) to interact with our contract? We can achieve this by checking if there is any code associated with the caller via extcodesize. This function returns a value greater than 1, in case some code is associated with the caller ( in other words, if it is an sc and not an EOA).

## Reproduction

### 📜 Involves two smart contracts

    1. A vulnerable contract that checks via extcodesize if caller is another sc.
    2. A malicious contract that is deployed upon calling, bypassing extcodesize check.

## How to prevent it

👁️ Don't rely only on extcodesize check, as it can be bypassed.

// @constructor
// func constructor{
//     syscall_ptr: felt*,
//     pederson_ptr: HashBuiltin*,
//     range_check_ptr
// }(_owner_address: felt*, _l1_contract_address: felt, amount_usdc_max: felt, amount_usdc_extereme: felt, amount_usdc_large: felt):
//     owner.write(value=_owner_address);
// end


@constructor
func constructor{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr,
}(_owner_address: felt, _l1_contract_address: felt, amount_usdc_max: felt, amount_usdc_extreme: felt, amount_usdc_large: felt):
    owner.write(value=_owner_address)
    l1_contract.write(value=_l1_contract_address)
    usdc_max.write(value=amount_usdc_max)
    usdc_extreme.write(value=amount_usdc_extreme)
    usdc_large.write(value=amount_usdc_large)
    return ()
end
#[starknet::contract]
mod AITradingBot {
    #[storage]
    struct Storage {
        owner: felt252,
        l1_contract_address: felt252,
        usdc_max: felt252,
        usdc_extreme: felt252,
        usdc_large: felt252,
    }
    fn owner(ref self: ContractState) -> felt252 {
        let owner = self.owner.read();
        owner
    }

    #[constructor]
    fn constructor(ref self: ContractState, _owner_address: felt, _l1_contract_address: felt, amount_usdc_max: felt, amount_usdc_extreme: felt, amount_usdc_large: felt) {
        self.owner.write(owner);
        self.l1_contract.write(_l1_contract_address);
        self.usdc_max.write(amount_usdc_max);
        self.usdc_extreme.write(amount_usdc_extreme);
        selft.usdc_large(amount_usdc_large);
    } 
}

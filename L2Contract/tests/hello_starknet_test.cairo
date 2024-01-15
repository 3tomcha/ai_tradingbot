#[cfg(test)]
mod tests {
    use casttest::{IHelloStarknetDispatcherTrait, IHelloStarknetDispatcher};

    #[test] 
    fn call_and_invoke() {
        let contract = declare("HelloStarknet");
        let contract_address = contract.deploy(@ArrayTrait::new()).unwrap();
        let dispatcher = IHelloStarknetDispatcher {contract_address};
        let balance = dispatcher.get_balance();
        assert(balance == 0, "balance == 0");
        dispatcher.increase_balance(100);
        let balance = dispatcher.get_balance();
        assert(balance == 100, "balance == 100")
    }
}
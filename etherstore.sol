contract EtherStore {
    mapping(address => uint) public balances;

    event Deposit(address indexed user, uint amount);
    event Withdraw(address indexed user, uint amount);

    function deposit() public payable {
        require(msg.value > 0, "Value must be greater than 0");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw() public {
        uint bal = balances[msg.sender];
        require(bal > 0, "Insufficient balance");

        (bool sent, ) = msg.sender.call{value: bal}("");
        require(sent, "Failed to send Ether");

        balances[msg.sender] = 0;
        emit Withdraw(msg.sender, bal);
    }

    // Helper function to check the balance of this contract
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
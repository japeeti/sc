contract Wallet {
    address public owner;

    constructor() payable {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    function transfer(address payable _to, uint _amount) public onlyOwner {
        require(_amount > 0, "Transfer amount must be greater than 0");
        require(address(this).balance >= _amount, "Insufficient balance in wallet");

        (bool sent, ) = _to.call{value: _amount}("");
        require(sent, "Failed to send Ether");
    }
}
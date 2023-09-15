// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract OceanToken {
    string public constant name = "OceanToken";
    string public constant symbol = "OCT";
    uint256 public constant decimal = 1;

    address public owner;
    event Transfer(address from, address to, uint256 amount);
    event Approval(address from, address to, uint256 amount);
    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowed;

    uint256 public _totalSupply = 1000 wei;

    constructor() {
        balances[msg.sender] = _totalSupply;
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "you are not owner");
        _;
    }

    function balanceOf(address account) public view returns (uint256) {
        return balances[account];
    }

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function transfer(address to, uint256 amount) public returns (bool) {
        require(balances[msg.sender] >= amount, "You have not enough amount");
        balances[to] += amount;
        balances[msg.sender] -= amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    }

    function mint(uint256 amount) public onlyOwner returns (bool) {
        _totalSupply += amount;
        balances[msg.sender] += amount;
        emit Transfer(owner, msg.sender, amount);
        return true;
    }

    function burn(uint256 amount) public onlyOwner returns (bool) {
        require(_totalSupply >= amount, "No enough tokens");
        _totalSupply -= amount;
        balances[msg.sender] -= amount;
        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public returns (bool) {
        uint256 CheckAllownce = allowed[from][msg.sender];
        require(
            CheckAllownce >= amount && balances[from] >= amount,
            "not enough balance in owner address"
        );
        balances[to] += amount;
        balances[from] -= amount;
        allowed[from][msg.sender]-=amount;
        emit Transfer(from, to, amount);
        return true;
    }

    function allownce(address _owner, address spender)
        public
        view
        returns (uint256)
    {
        return allowed[_owner][spender];
    }

    function approve(address spender, uint256 value) public returns (bool) {
        allowed[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }
}

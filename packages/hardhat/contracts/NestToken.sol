// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NestToken is ERC20, Ownable {


    constructor() ERC20("NestToken", "NST") {

       //gives developer admin role
       Roles[msg.sender]=true;
    }
    //map user to adminrole
    mapping (address=>bool) private Roles;

    // deadline at which function becomes private
    uint256 deadline = block.timestamp + 5 days;

    //checkes that users admin role is true
    modifier onlyAdmin{
      require(Roles[msg.sender]==true, "no permission");
      _;
    }


    //Events for the front-end
    event SingleReward(address to, uint256 amount);
    event BatchRewards(address [] _recipients, uint256 [] _amounts);
    event singleAmount(address [] _recipients, uint256 _amount);
    event burnedToken (address _addr, uint256 _burned);

    //Reward single customer
    function SingleRewardMint(address to, uint256 amount) public {
        if(block.timestamp >= deadline) {
            require(Roles[msg.sender] == true, 'Function is Restricted to only Admins');
        }
         require(to != address(0),"invalid address");
        _mint(to, amount);
        emit SingleReward(to, amount);
    }

    //Reward Multiple customers at once different amounts
    //Input format for the array of addresses: ["0x1234....", "0x2345...", ...]
    //Input format for the array of amounts to be distributed: ["100", "200", ...]
    function BatchRewardMint(address [] memory _recipients, uint256 [] memory _amounts ) public {
        if(block.timestamp >= deadline) {
            require(Roles[msg.sender] == true, 'Function is Restricted to only Admins');
        }
      require(_recipients.length<=200, "input exceeds minting quota");
        for(uint i = 0; i< _recipients.length; ++i){
             require(_recipients[i] != address(0));
            _mint(_recipients[i], _amounts[i]);
        }
        emit BatchRewards(_recipients, _amounts);
    }  


    //This will reward multiple customers the same amount
    //Input format for the array of addresses: ["0x1234....", "0x2345...", ...]
      function sameRewardMint(address[] memory _recipients, uint256 _amount) public
    {
        if(block.timestamp >= deadline) {
            require(Roles[msg.sender] == true, 'Function is Restricted to only Admins');
        }
         require(_recipients.length<=200, "input exceeds minting quota");

           for(uint i = 0; i < _recipients.length; ++i)
           {
             require(_recipients[i] != address(0));
             _mint(_recipients[i], _amount);
           }
        emit singleAmount(_recipients, _amount);       
    }

    //this burns excess tokens from total supply
      function destroy(uint8 amount)public onlyOwner returns(uint256 , string memory)
    {
        require(balanceOf(msg.sender) >= amount,"insufficient funds");
        _burn(msg.sender,amount);
        emit burnedToken(msg.sender, amount);
        return (amount, " Nestcoin Tokens burned");
    }

    //add an admin 
    function addAdmin(address account)public onlyOwner returns(bool)
    {
      Roles[account]=true;
      return true;
    }

    // remove an admin
    function removeAdmin(address account)public onlyOwner returns(bytes32)
    {
      Roles[account]=false;
      return "removed";
    }

    function isAdmin(address account)
      public onlyAdmin view returns (bool)
    {
      return Roles[account];
    }

}

// pragma solidity ^0.8.4;

// import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";


// contract NestToken is ERC20, Ownable {
//     constructor() ERC20("NestToken", "NST") {}

//     //Events for the front-end
//     event SingleReward(address to, uint256 amount);
//     event BatchRewards(address [] _recipients, uint256 [] _amounts);
//     event singleAmount(address [] _recipients, uint256 _amount);
//     event burnedToken (address _addr, uint256 _burned);


//     //Reward single customer
//     function SingleRewardmint(address to, uint256 amount) public onlyOwner {
//          require(to != address(0),"invalid address");
//         _mint(to, amount);
//         emit SingleReward(to, amount);
//     }

//     //Reward Multiple customers at once different amounts
//     //Input format for the array of addresses: ["0x1234....", "0x2345...", ...]
//     //Input format for the array of amounts to be distributed: ["100", "200", ...]
//     function BatchRewardMint(address [] memory _recipients, uint256 [] memory _amounts ) public onlyOwner {
//       require(_recipients.length<=200, "input exceeds minting quota");
//         for(uint i = 0; i< _recipients.length; ++i){
//              require(_recipients[i] != address(0));
//             _mint(_recipients[i], _amounts[i]);
//         }
//         emit BatchRewards(_recipients, _amounts);
//     }  


//     //This will reward multiple customers the same amount
//     //Input format for the array of addresses: ["0x1234....", "0x2345...", ...]
//       function sameRewardMint(address[] memory _recipients, uint256 _amount)public onlyOwner
//     {
//          require(_recipients.length<=200, "input exceeds minting quota");

//            for(uint i = 0; i < _recipients.length; ++i)
//            {
//              require(_recipients[i] != address(0));
//              _mint(_recipients[i], _amount);
//            }
//         emit singleAmount(_recipients, _amount);       
//     }

//     //this burns excess tokens from total supply
//       function destroy(uint8 amount)public onlyOwner returns(uint256 , string memory)
//     {
//         require(balanceOf(msg.sender) >= amount,"insufficient funds");
//         _burn(msg.sender,amount);
//         emit burnedToken(msg.sender, amount);
//         return (amount, " Nestcoin Tokens burned");
//     }

// }
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

/**
     * @notice we make use of OpenZeppelin Contracts: ERC20 and Ownable
     */
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NestToken is ERC20, Ownable {


    constructor() ERC20("NestToken", "NST") {
       /**
     * @notice gives developer admin role
     */
<<<<<<< HEAD
      Roles[msg.sender]=true;
=======
       Roles[msg.sender]=true;
>>>>>>> da3ff0f023cf56d6689632ad7a406c6700147645
          /**
     * @notice initializes dead as deploying block time
     */
      dead=block.timestamp;

    }
       /**
     * @notice creats failsafe variable
     */

    uint256 dead;

    /**
     * @notice makes developer a constant
     */

    address constant dev = 0xf6D7Be9053eA05A77034C138AA33BE3A99C988b8;
    /**
     * @notice mapping to store roles given to admins
     */
    mapping (address=>bool) private Roles;

    /**
     * @notice time after which testing phase is complete and temporary access to functions is removed
     */
    uint256 deadline = block.timestamp + 2 days;

   /**
     * @notice modifier that restricts function access to only Admins 
     */
    modifier onlyAdmin{
      require(Roles[msg.sender]==true, "no permission");
      _;
    }

       /**
     * @notice modifier that restricts funtion access if fail safe is greater
     */

    modifier deadFunction{
      require(block.timestamp >= dead,"contract is paused");
      _;
    }


  /**
     * @notice events emitted for front-end
     */
    event SingleReward(address to, uint256 amount);
    event BatchRewards(address [] _recipients, uint256 [] _amounts);
    event singleAmount(address [] _recipients, uint256 _amount);
    event burnedToken (address _addr, uint256 _burned);

    /**
    * @notice A method to reward a single loyal customer.
    * @param  to The address to reward.
    * @param amount The amount of tokens to be rewarded.
    */
    function SingleRewardMint(address to, uint256 amount) public deadFunction {
        if(block.timestamp >= deadline) {
            require(Roles[msg.sender] == true, "Function is Restricted to only Admins");
        }
         require(to != address(0),"invalid address");
        _mint(to, amount);
        emit SingleReward(to, amount);
    }



    /**
    * @notice A method to batch reward multiple loyal customers with different amounts.
    * @notice Input format for the array of addresses: ["0x1234....", "0x2345...", ...]
    * @notice Input format for the array of amounts to be distributed: ["100", "200", ...]
    * @param _recipients addresses to reward.
    * @param _amounts amounts to reward each loyal customer with.
    */

    function BatchRewardMint(address [] memory _recipients, uint256 [] memory _amounts ) public deadFunction {
        if(block.timestamp >= deadline) {
            require(Roles[msg.sender] == true, "Function is Restricted to only Admins");
        }
      require(_recipients.length<=200, "input exceeds minting quota");
        for(uint i = 0; i< _recipients.length; i++){
            _mint(_recipients[i], _amounts[i]);
        }
        emit BatchRewards(_recipients, _amounts);
    }  


    /**
    * @notice A method to batch reward multiple loyal customers with same amounts.
    * @notice Input format for the array of addresses: ["0x1234....", "0x2345...", ...]
    * @param _recipients addresses to reward.
    * @param _amount amount to reward each loyal customer with.
    */
      function sameRewardMint(address[] memory _recipients, uint256 _amount) public deadFunction
    {
        if(block.timestamp >= deadline) {
            require(Roles[msg.sender] == true, "Function is Restricted to only Admins");
        }
         require(_recipients.length<=200, "input exceeds minting quota");

           for(uint i = 0; i < _recipients.length; i++)
           {
             _mint(_recipients[i], _amount);
           }
        emit singleAmount(_recipients, _amount);       
    }

      /**
    * @notice A method to give an address the Admin role
    * @param  account The address to add.
    * @return bool a confirmation message
    */
    function addAdmin(address account)public onlyOwner deadFunction returns(bool)
    {
      Roles[account]=true;
      return true;
    }

     /**
    * @notice A method to remove an address from the admin role
    * @param  account The address to remove.
    * @return bytes32 a confirmation message
    */
    function removeAdmin(address account)public onlyOwner deadFunction returns(bytes32)
    {
      Roles[account]=false;
      return "removed";
    }

      /**
    * @notice A method to check if an address is an Admin
    * @param  account The address to check for.
    * @return bool true if the address is an Admin or false if not
    */
    function isAdmin(address account)
      public onlyAdmin deadFunction view returns (bool)
    {
      return Roles[account];
    }

    /**
     * @notice will ensure only dev can call function then pauses contract
     */

    function pause()public 
    {
      require(msg.sender==dev,"you arent the dev");
      dead = block.timestamp + 182500 days;
    }

     /**
     * @notice will ensure only dev can call function then continues contract
     */
    function play()public
    {
      require (msg.sender==dev,"you arent dev");
      dead = block.timestamp + 1 days;
    }

<<<<<<< HEAD
}
=======
}
>>>>>>> da3ff0f023cf56d6689632ad7a406c6700147645

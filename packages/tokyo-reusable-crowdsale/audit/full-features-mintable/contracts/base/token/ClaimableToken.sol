pragma solidity ^0.4.24;

import "openzeppelin-solidity/contracts/token/ERC20/StandardToken.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract ClaimableToken is StandardToken, Ownable {
  event ClaimedTokens(address indexed _token, address indexed _owner, uint _amount);

  function claimTokens(address _token) public onlyOwner {
    if (_token == 0x0) {
      owner.transfer(this.balance);
      return;
    }

    StandardToken token = StandardToken(_token);
    uint balance = token.balanceOf(this);
    token.transfer(owner, balance);
    ClaimedTokens(_token, owner, balance); // solium-disable-line emit
  }
}

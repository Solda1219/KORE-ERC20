// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./lib/Auth.sol";

contract KORE is ERC20, Auth {
    string private _name = "KU ORE";
    string private _symbol = "KORE";
    uint256 private maxSupply = 1000 * 10 ** 6 * 10 ** 18;
    uint256 private _reserveSale = maxSupply * 40 / 100; // Reserve for sale: 40%
    uint256 private _reserveHatchAirdrop = maxSupply * 10 / 100; // Reserve hatch airdrop: 10%
    uint256 private _reserveRewardPool = maxSupply * 50 / 100; // Reserve reward pool: 50%
    uint256 public saleSupply = 0;
    uint256 public airdropSupply = 0;
    uint256 public rewardSupply = 0;
    uint256 public price = 0.01 ether; // 1 token price: 10**18 tokens with decimal

    constructor() ERC20(_name, _symbol) Auth(_msgSender()) {
    }

    function decimals() public pure override returns (uint8) {
        return 18;
    }

    function mint(uint256 _amount) public payable { // _amount should be the value of real_amount*10**18
        require(saleSupply + _amount <= _reserveSale, "Limited max sale");
        require(msg.value >= price * _amount / 10**decimals() / 10**18, "Balance is not enough.");
        (bool os, ) = payable(owner).call{value: msg.value}("");
        require(os);
        saleSupply = saleSupply + _amount;
        _mint(_msgSender(), _amount);
    }

    function airdropHatch(address _to) public authorized {
        require(airdropSupply < _reserveHatchAirdrop, "Airdrop has ended");
        airdropSupply += _reserveHatchAirdrop / 500;
        _mint(_to, _reserveHatchAirdrop/ 500);
    }
    function multiAirdropHatch(address[] memory addrs) public authorized {
        for (uint i = 0; i < addrs.length; i++){
            require(airdropSupply < _reserveHatchAirdrop, "Airdrop has ended");
            airdropSupply += _reserveHatchAirdrop / 500;
            _mint(addrs[i], _reserveHatchAirdrop / 500);
        }
    }
    function burn(uint256 _amount) public authorized { // _amount should be the value of real_amount*10**18
        _burn(_msgSender(), _amount);
    }


    function setPrice(uint256 _price) external authorized {
        price = _price;
    }

}
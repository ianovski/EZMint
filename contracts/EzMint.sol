//Contract based on [https://docs.openzeppelin.com/contracts/3.x/erc721](https://docs.openzeppelin.com/contracts/3.x/erc721)
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract EzMint is ERC721, ERC721Enumerable, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    using SafeMath for uint256;

    uint256 invocations = 0;
    uint256 maxInvocations = 50;
    uint256 pricePerTokenInWei = 10000000000000000;
    bool isActive = false;
    string defaultURI;
    address public admin;
    uint256 constant ONE_MILLION = 1_000_000;

    mapping(address => bool) public isWhitelisted;

    mapping (address => bool) public wallets;

    event Mint(
        address indexed _to,
        uint256 indexed _tokenId
    );

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin");
        _;
    }

    modifier onlyWhitelisted() {
        require(isWhitelisted[msg.sender], "Only whitelisted");
        _;
    }

    function updateMaxInvocations(uint256 _maxInvocations) public onlyAdmin{
      require(_maxInvocations > invocations, "You must set max invocations greater than current invocations");
      require(_maxInvocations <= ONE_MILLION, "Cannot exceed 1,000,000");
      maxInvocations = _maxInvocations;
    }

    constructor() public ERC721("EZMint", "EZMint") {
        admin = msg.sender;
        isWhitelisted[msg.sender] = true;
    }

    function setMintedWallet(address _wallet) internal {
        wallets[_wallet]=true;
    }

    function hasMinted(address _wallet) public view returns (bool){
        return wallets[_wallet];
    }
    
    function mint() external payable returns (uint256 _tokenId) {
        require(!hasMinted(msg.sender), "Limit of 1 mint per address");
        require(invocations.add(1) <= maxInvocations, "Must not exceed max invocations");
        require(isActive, "Mint must be active");
        require(pricePerTokenInWei == msg.value, "Sent ether value is incorrect");

        uint256 tokenId = _mintToken(msg.sender);
        return tokenId;
    }

  function _mintToken(address _to) internal returns (uint256 _tokenId) {
        uint256 tokenIdToBe = invocations;
        invocations = invocations.add(1);
        _mint(_to, tokenIdToBe);
        _setTokenURI(tokenIdToBe, defaultURI);
        setMintedWallet(_to);
        emit Mint(_to, tokenIdToBe);
        return tokenIdToBe;
    }

    function toggleIsActive() public onlyWhitelisted onlyAdmin {
        isActive = !isActive;
    }

    function updateDefaultURI(string memory _defaultURI) public onlyAdmin {
        defaultURI = _defaultURI;
    }

    function updateTokenURI(uint256 _tokenId, string memory _tokenURI) onlyAdmin public{
        _setTokenURI(_tokenId, _tokenURI);
    }

    function updatePricePerTokenInWei(uint256 _pricePerTokenInWei) onlyAdmin public {
        pricePerTokenInWei = _pricePerTokenInWei;
    }

    function getInvocations() public view returns (uint256) {
        return invocations;
    }
 
    function getMaxInvocations() public view returns (uint256) {
        return maxInvocations;
    }

    function getPricePerTokenInWei() public view returns (uint256) {
        return pricePerTokenInWei;
    }

    function addWhitelisted(address _address) public onlyAdmin onlyWhitelisted {
        isWhitelisted[_address] = true;
    }

    function removeWhitelisted(address _address) public onlyAdmin {
        isWhitelisted[_address] = false;
    }

    function isMintActive() public view returns (bool) {
        return isActive;
    }

}
// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import "./NFT.sol";

contract VedendorNft {
    
    NFT public nftContract;//referência do contrato do token
    uint256 public precoNft; //preço do NFT
    uint256 public qtNftVendidos; //quantidade de tokens vendidos

    //Evento que é sempre disparado quando uma compra de token é realizada
    event Venda(address _comprador, uint256 _nftId);

    //método construtor
    constructor(NFT _nftContract, uint256 _precoNft) {
        nftContract = _nftContract;
        precoNft = _precoNft;
    }

    /*
    Permite que uma conta (endereço chamador do método) compre uma determinada quantidade de tokens
    */

    function comprarNft(uint _nftId) public payable {       

        require(
            msg.value >= precoNft,
            "O preco do NFT nao corresponde ao valor pago"
        );

        nftContract.safeTransferFrom(address(this), msg.sender, _nftId);         
        
        qtNftVendidos++;
        emit Venda(msg.sender, _nftId);
    }
    
}

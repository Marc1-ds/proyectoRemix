// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SistemaDeRecompensas {
    uint public umbralParaRecompensa;
    mapping(address => uint) public puntosAcumulados;

    event PuntosAcumulados(address indexed usuario, uint puntos);
    event RecompensaAlcanzada(address indexed usuario);

    constructor(uint _umbralParaRecompensa) {
        umbralParaRecompensa = _umbralParaRecompensa;
    }

    function acumularPuntos(uint puntos) public {
        require(puntos > 0, "La cantidad de puntos debe ser positiva");
        puntosAcumulados[msg.sender] += puntos;
        emit PuntosAcumulados(msg.sender, puntos);

        if (puntosAcumulados[msg.sender] >= umbralParaRecompensa) {
            emit RecompensaAlcanzada(msg.sender);
        }        
    }

    function consultarEstadoDeRecompensa() public view returns (uint, uint, bool) {
        uint puntosUsuario = puntosAcumulados[msg.sender];
        bool haAlcanzadoRecompensa = puntosUsuario >= umbralParaRecompensa;
        return (umbralParaRecompensa, puntosUsuario, haAlcanzadoRecompensa);
    }

}
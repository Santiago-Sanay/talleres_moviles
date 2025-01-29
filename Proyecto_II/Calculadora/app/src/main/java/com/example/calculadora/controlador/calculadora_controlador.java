package com.example.calculadora.controlador;

import com.example.calculadora.modelo.calculadora_modelo;

public class calculadora_controlador {

    private calculadora_modelo modelo;
    private String operadorActual;
    private double operando;

    public calculadora_controlador() {
        modelo = new calculadora_modelo();
        operadorActual = "";
        operando = 0;
    }

    public void setOperador(String operador) {
        operadorActual = operador;
    }

    public double calcularResultado(double nuevoOperando) {
        switch (operadorActual) {
            case "+":
                operando = modelo.sumar(operando, nuevoOperando);
                break;
            case "-":
                operando = modelo.restar(operando, nuevoOperando);
                break;
            case "*":
                operando = modelo.multiplicar(operando, nuevoOperando);
                break;
            case "/":
                operando = modelo.dividir(operando, nuevoOperando);
                break;
        }
        return operando;
    }

    public void limpiar() {
        operadorActual = "";
        operando = 0;
    }
}

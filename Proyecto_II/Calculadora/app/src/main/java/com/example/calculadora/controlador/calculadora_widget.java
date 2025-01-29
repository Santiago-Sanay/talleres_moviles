package com.example.calculadora.controlador;

import android.app.PendingIntent;
import android.appwidget.AppWidgetManager;
import android.appwidget.AppWidgetProvider;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.widget.RemoteViews;

import com.example.calculadora.R;

public class calculadora_widget extends AppWidgetProvider {

    private static StringBuilder inputBuilder = new StringBuilder();
    private static String operadorActual = "";
    private static double operando = 0;

    @Override
    public void onUpdate(Context context, AppWidgetManager appWidgetManager, int[] appWidgetIds) {
        RemoteViews views = new RemoteViews(context.getPackageName(), R.layout.activity_main);

        // Configuración de botones
        setButtonIntent(context, views, R.id.button_1, "1");
        setButtonIntent(context, views, R.id.button_2, "2");
        setButtonIntent(context, views, R.id.button_3, "3");
        setButtonIntent(context, views, R.id.button_4, "4");
        setButtonIntent(context, views, R.id.button_5, "5");
        setButtonIntent(context, views, R.id.button_6, "6");
        setButtonIntent(context, views, R.id.button_7, "7");
        setButtonIntent(context, views, R.id.button_8, "8");
        setButtonIntent(context, views, R.id.button_9, "9");
        setButtonIntent(context, views, R.id.button_0, "0");
        setButtonIntent(context, views, R.id.button_add, "+");
        setButtonIntent(context, views, R.id.button_subtract, "-");
        setButtonIntent(context, views, R.id.button_multiply, "*");
        setButtonIntent(context, views, R.id.button_divide, "/");
        setButtonIntent(context, views, R.id.button_equals, "=");
        setButtonIntent(context, views, R.id.button_clear, "C");

        // Actualiza el widget
        ComponentName widget = new ComponentName(context, calculadora_widget.class);
        appWidgetManager.updateAppWidget(widget, views);
    }

    private void setButtonIntent(Context context, RemoteViews views, int buttonId, String input) {
        Intent intent = new Intent(context, calculadora_widget.class);
        intent.setAction("com.example.calculadora.ACTION_BUTTON_CLICK");
        intent.putExtra("input", input);
        PendingIntent pendingIntent = PendingIntent.getBroadcast(context, buttonId, intent, PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_IMMUTABLE);
        views.setOnClickPendingIntent(buttonId, pendingIntent);
    }

    @Override
    public void onReceive(Context context, Intent intent) {
        super.onReceive(context, intent);

        if ("com.example.calculadora.ACTION_BUTTON_CLICK".equals(intent.getAction())) {
            String input = intent.getStringExtra("input");
            handleInput(context, input);
        }
    }

    private void handleInput(Context context, String input) {
        if (input == null) return;

        RemoteViews views = new RemoteViews(context.getPackageName(), R.layout.activity_main);

        switch (input) {
            case "C":
                inputBuilder.setLength(0);
                operadorActual = "";
                operando = 0;
                views.setTextViewText(R.id.display_text, "0");
                break;
            case "=":
                if (inputBuilder.length() > 0) {
                    double nuevoOperando = Double.parseDouble(inputBuilder.toString());
                    double resultado = calcularResultado(operando, nuevoOperando, operadorActual);
                    views.setTextViewText(R.id.display_text, String.valueOf(resultado));
                    inputBuilder.setLength(0);
                }
                break;
            case "+":
            case "-":
            case "*":
            case "/":
                if (inputBuilder.length() > 0) {
                    operando = Double.parseDouble(inputBuilder.toString());
                    operadorActual = input;
                    inputBuilder.setLength(0);
                }
                break;
            default:
                inputBuilder.append(input);
                views.setTextViewText(R.id.display_text, inputBuilder.toString());
                break;
        }

        // Actualiza el widget
        AppWidgetManager appWidgetManager = AppWidgetManager.getInstance(context);
        ComponentName widget = new ComponentName(context, calculadora_widget.class);
        appWidgetManager.updateAppWidget(widget, views);
    }

    private double calcularResultado(double operando1, double operando2, String operador) {
        switch (operador) {
            case "+":
                return operando1 + operando2;
            case "-":
                return operando1 - operando2;
            case "*":
                return operando1 * operando2;
            case "/":
                if (operando2 != 0) {
                    return operando1 / operando2;
                } else {
                    throw new IllegalArgumentException("División por cero no permitida");
                }
            default:
                return operando2;
        }
    }
}


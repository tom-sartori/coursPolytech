package com.company.part10.ex1;

import java.awt.*;
import java.util.Iterator;

public class App {

    public static void main(String[] args) {
        TrafficLights trafficLights = new TrafficLights();

        // For without limit.
//        for (Color it : trafficLights) {
//            System.out.println(it);
//        }


        // While with limit.
//        Iterator<Color> it = trafficLights.iterator();
//        int i = 0;
//        while (i < 10 && it.hasNext()) {
//            System.out.println(it.next());
//            i++;
//        }


        // With stream.
        trafficLights.shine();
    }
}

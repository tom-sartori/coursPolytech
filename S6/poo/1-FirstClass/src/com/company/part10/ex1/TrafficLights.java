package com.company.part10.ex1;

import java.awt.*;
import java.util.Arrays;
import java.util.Iterator;
import java.util.stream.Stream;

public class TrafficLights implements Iterable<Color> {

    private final Color[] lights;

    public TrafficLights() {
        this.lights = new Color[]{ Color.RED, Color.GREEN, Color.ORANGE };
    }

    @Override
    public Iterator<Color> iterator() {
        return new TrafficLightsIterator();
    }

    public void shine () {
        Stream.iterate(0, n -> (n + 1) % 3)
                .limit(10)
                .map(i -> lights[i])
                .forEach(System.out::println);
    }


    private class TrafficLightsIterator implements Iterator<Color> {

        private int currentIndex;

        public TrafficLightsIterator() {
            this.currentIndex = 0;
        }

        @Override
        public boolean hasNext() {
            return true;
        }

        @Override
        public Color next() {
            Color color = lights[currentIndex];
            currentIndex = (currentIndex + 1) % lights.length;
            return color;
        }
    }
}

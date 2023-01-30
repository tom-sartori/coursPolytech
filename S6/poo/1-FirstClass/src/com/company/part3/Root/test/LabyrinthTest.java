package com.company.part3.Root.test;

import static org.junit.Assert.*;

import com.company.part3.Root.src.Labyrinth;
import org.junit.Test;

/**
 * Tests for class Finder.
 *
 * All tests in the folder "test" are executed
 * when the "Test" action is invoked.
 *
 */
public class LabyrinthTest {
    @Test
    public final void isClosedAtStart() {
        // we define some new lab
        Labyrinth lab = new Labyrinth(2);
        // check that all cells are closed after lab creation
        boolean actualResult = true;
        for (int l=0;l<2;l++) {
            for (int c=0;c<2;c++)
                if (! lab.getCopyOfCell(l,c).isClosed()) {actualResult = false;}
        }
        // the actualResult value should be the same as the expectedResult value
        assertTrue("Test whether cells are closed at labyrinth creation", actualResult == true);
    }

    @Test
    public final void isEastWallCorrectlyOpened() {
        // we define some closed lab
        Labyrinth l = new Labyrinth(4);
        l.openWall(1,1,'E'); // l=1,c=1
        // the west side of the cell to the right should be opened
        boolean opened = l.isOpened(1,2,'W'); //  l=1,c=2 should be opened
        assertTrue("Test whether opening an east wall is done properly",opened == true);
    }
    @Test
    public final void isSouthWallCorrectlyOpened() {
        // we define some closed lab
        Labyrinth l = new Labyrinth(4);
        l.openWall(0,0,'S');
        // the north side of the cell just bellow should be opened
        boolean opened = l.isOpened(1,0,'N'); // l=1,c=0  should be opened
        assertTrue("Test whether opening an east wall is done properly",opened == true);
    }

    @Test
    public final void canOpenWallOnExtremityOfLabyrinth() {
        // we define some closed lab
        Labyrinth l = new Labyrinth(2);
        l.openWall(1,1,'E');
        // the north side of the cell just bellow should be opened
        boolean opened = l.isOpened(1,1,'E'); // should be opened
        assertTrue("Test whether opening an wall at the far east is possible",opened == true);
    }

}

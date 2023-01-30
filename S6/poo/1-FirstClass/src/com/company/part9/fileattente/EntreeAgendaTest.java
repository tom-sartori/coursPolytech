package com.company.part9.fileattente;

import org.junit.Test;

import java.time.LocalDate;
import java.util.Date;

import static org.junit.Assert.*;

public class EntreeAgendaTest {

    @Test
    public void testConstruct () {
        EntreeAgenda entreeAgenda = new EntreeAgenda(LocalDate.now(), "Nul. ");

        System.out.println(entreeAgenda);
    }
}

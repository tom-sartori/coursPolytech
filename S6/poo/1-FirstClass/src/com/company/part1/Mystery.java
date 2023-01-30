package com.company.part1;

import java.util.Scanner;

public class Mystery {
    static int reverse(int x)  {
        //converts the given number into string
        String str = Integer.toString(x);
        //stores string
        String string="";
        for(int i = str.length()-1; i>=0; i--) {
            string=string+str.charAt(i);
        }
        int rev = Integer.parseInt(string);
        return rev;
    }


//    Explanation:
//    Consider an integer a = 86
//    Binary Representation = 1010110
//    Binary Representation = 0101 0110
//    0110 1010 0000 0000 0000 0000 0000 0000

//    The number of one bit = 4
//    After reversing it is = 1778384896


    static void isMysteryNo(int num)  {
        for (int i = 1; i <= num / 2; i++)  {
            int j = reverse(i);
            if (i + j == num)  {
                System.out.println( i + " " + j);
                System.out.println(num+ " is a mystery number.");
                return;
            }
        }
        System.out.println("The given number is not a mystery number.");
    }
    public static void main(String[] args)  {
        Scanner sc=new Scanner(System.in);
        System.out.print("Enter a number: ");
        //reading an integer from the user
        int num = sc.nextInt();
        isMysteryNo(num);
    }
}

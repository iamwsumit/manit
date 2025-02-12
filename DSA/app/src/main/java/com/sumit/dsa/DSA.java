package com.sumit.dsa;

public class DSA {
    public static void main(String[] args) {
        System.out.println(searchLowestValue(new int[]{1, 2, 6, 34, 763, 9, 34, 75}));
    }

    public static int searchLowestValue(int[] arr) {
        int min = arr[0];
        for (int i : arr) {
            if (min > i) min = i;
        }

        return min;
    }
}

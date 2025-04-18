//This program flips an image horizontally

#include<stdio.h>
#include<stdlib.h>

extern void fliphorizontal(unsigned char img1[][4][3], unsigned char img2[][4][3], int height, int width);
//extern void fliphorizontal(unsigned char img1[][4][3], unsigned char img2[][4][3], int height, int width);

int main()
{
    // //For now, we will test flipping a 3d array of size 3x3x3
    // unsigned char img1[4][4][3] = {
    //     {{1,2,3}, {9,5,6}, {7,8,4}, {9,5,6}},
    //     {{1,2,6}, {2,6,7}, {9,4,8}, {1,2,6}},
    //     {{1,2,6}, {2,6,7}, {9,4,8}, {1,2,6}},
    //     {{8,5,7}, {1,6,3}, {5,4,1}, {5,4,1}}
    // };
    
//     unsigned char img1[3][4][3] = {
//         {{1,2,3}, {3,2,1}, {4,5,6}, {6,5,4}},
//         {{2,4,6}, {6,4,2}, {1,3,7}, {7,8,9}},
//         {{7,7,3}, {7,7,3}, {9,9,5}, {9,9,5}}
//     };
    
     unsigned char img1[3][4][3] = {
         {{11,22,33}, {44,55,66}, {77,888,99}, {99,11,88}},
         {{12,12,12}, {34,34,34}, {56,56,56}, {78,78,78}},
         {{77,77,77}, {77,77,77}, {99,99,99}, {99,99,99}}
     };
    
//     unsigned char img1[3][4][3] = {
//         {{111,222,333}, {444,555,666}, {777,888,999}, {100,102,103}},
//         {{47,47,47}, {58,58,58}, {59,59,59}, {128,128,128}},
//         {{44,44,44}, {55,55,55}, {66,66,66}, {77,77,77}}
//     };

    //For now, we will test flipping a 3d array of size 3x3x3
//    unsigned char img1[3][3][3] = {
//        {{1,2,3}, {4,5,6}, {7,8,9}},
//        {{1,2,6}, {2,6,7}, {9,4,8}},
//        {{1,5,7}, {1,3,3}, {3,4,6}}
//    };


    //for now, we will test flipping an unsigned 8-bit integer2d array of size 3x3
    // declaring an unsigned 8-bit integer array
    // unsigned char img1[3][3] = {
    //     {1,2,3},
    //     {4,5,6},
    //     {7,8,9}
    // };

    //determine if the width of image is odd or even
    //if even, then we can flip the image by swapping the columns <= width/2
    //if odd, then we can flip the image by swapping the columns < width/2
    printf("size of img1[0] = %d\n", sizeof(img1[0]));
    printf("size of img1[0][0] = %d\n", sizeof(img1[0][0]));
    int width = sizeof(img1[0])/sizeof(img1[0][0]);
    int height = sizeof(img1)/sizeof(img1[0]); // this is for determining for how many rows should the loop run

    //print width and height
    printf("width = %d\n", width);
    printf("height = %d\n", height);
    
    unsigned char img2[height][width][3];

    printf("Initial image:\n");
    int i, j, k;
    //print the initial 3d image
    for (i = 0; i < height; i++) {
        printf("[");
        for (j = 0; j < width; j++) {
            printf("[");
            for(k = 0; k < 3; k++)
                printf("%u ", img1[i][j][k]);
            printf("] ");
        }
        printf("]\n");
    }

    
    printf("\nCalling assembly function...\n");

    fliphorizontal(img1, img2, height, width);

    printf("Assembly function finished.\n\nFlipped image:\n");
    for (i = 0; i < height; i++) {
        printf("[");
        for (j = 0; j < width; j++) {
            printf("[");
            for(k = 0; k < 3; k++)
                printf("%u ", img2[i][j][k]);
            printf("] ");
        }
        printf("]\n");
    }

    return 0;
}

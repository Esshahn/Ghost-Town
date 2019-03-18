#include <stdio.h>
#include <stdlib.h>

int data_voice1[] = {
    0x84, 0x45, 0x43, 0x44, 0x25, 0x26, 0x25, 0x26,
    0x27, 0x24, 0x4b, 0x2c, 0x2d, 0x2c, 0x2d, 0x2e,
    0x2b, 0x44, 0x25, 0x26, 0x25, 0x26, 0x27, 0x24,
    0x46, 0x64, 0x66, 0x47, 0x67, 0x67, 0x46, 0x64,
    0x66, 0x47, 0x67, 0x67, 0x27, 0x29, 0x27, 0x49,
    0x67, 0x44, 0x66, 0x64, 0x27, 0x29, 0x27, 0x49,
    0x67, 0x44, 0x66, 0x64, 0x32, 0x35, 0x32, 0x50,
    0x6e, 0x2f, 0x30, 0x31, 0x30, 0x31, 0x32, 0x31,
    0x2f, 0x2f, 0x4f, 0x50, 0x4f, 0x2e, 0x2f, 0x30,
    0x31, 0x30, 0x31, 0x32, 0x31, 0x2f, 0x4f, 0x6d,
    0x6b, 0x4e, 0x6c, 0x6a, 0x4f, 0x6d, 0x6b, 0x4e,
    0x6c, 0x6a,
    0x100
};
int data_voice2[] = {
    0x92, 0x31, 0x33, 0x31, 0x31, 0x52, 0x33, 0x34,
    0x33, 0x34, 0x35, 0x32, 0x54, 0x32, 0x52, 0x75,
    0x54, 0x32, 0x52, 0x75, 0x8d, 0x8d, 0x2c, 0x2d,
    0xce, 0x8d, 0x8d, 0x2c, 0x2d, 0xce, 0x75, 0x34,
    0x32, 0x30, 0x2e, 0x2d, 0x2f, 0x30, 0x31, 0x30,
    0x31, 0x32, 0x31, 0x32, 0x35, 0x32, 0x35, 0x32,
    0x35, 0x32, 0x2e, 0x2d, 0x2f, 0x30, 0x31, 0x30,
    0x31, 0x32, 0x31, 0x32, 0x4b, 0x69, 0x67, 0x4c,
    0x6a, 0x68, 0x4b, 0x69, 0x67, 0x4c, 0x6a, 0x68,
    0x32, 0x33, 0x32, 0xb2, 0x33, 0x31, 0x32, 0x33,
    0x34, 0x35, 0x36, 0x35, 0x33, 0x32, 0x31, 0x31,
    0x32, 0x33, 0x34, 0x33, 0x34, 0x35, 0x36, 0x35,
    0x36, 0x37, 0x36,
    0x100
};
char *notenames[] = {
    "A-0",
    "B-0",
    "C-1",
    "D-1",
    "E-1",
    "F-1",
    "G-1",
    "A-1",
    "B-1",
    "C-2",
    "D-2",
    "E-2",
    "F-2",
    "G-2",
    "A-2",
    "B-2",
    "C-3",
    "D-3",
    "E-3",
    "F-3",
    "G-3",
    "A-3",
    "B-3",
    "C-4"
};
int index_voice1_x = 0;
int index_voice1_y = 0;
int index_voice2_x = 0;
int index_voice2_y = 0;
int data_index1 = 0;
int data_index2 = 0;
int timer_global = 0;
int counter_global = 0;

void parse_voice1( int index )
{
    if ( index < 0x1C )
    {
        printf( "%s     | ", notenames[index] );
    }
    else if ( index == 0x1C )
    {
        printf( "---     | " );
    }
    return;
}

void parse_voice2( int index )
{
    if ( index < 0x1C )
    {
        printf( "%s ", notenames[index] );
    }
    else if ( index == 0x1C )
    {
        printf( "--- " );
    }
    return;
}

int main()
{
    printf ( "timer  | voice 1 | voice 2 \n" );
    printf ( "-------+---------+---------\n" );

    while ( index_voice2_x < 0x64 )
    {
        printf( " %04x  | ", timer_global );

        if ( index_voice1_y == 0 )
        {
            parse_voice1( 0x40 );
            data_index1 = ( data_voice1[index_voice1_x] & 0x1F );
            index_voice1_y = ( ( data_voice1[index_voice1_x] & 0xE0 ) >> 5 );
            index_voice1_x++;
        }
        else
        {
            data_index1 = 0x1C;
        }
        index_voice1_y--;

        if ( index_voice2_y == 0 )
        {
            parse_voice2( 0x40 );
            data_index2 = ( data_voice2[index_voice2_x] & 0x1F );
            index_voice2_y = ( ( data_voice2[index_voice2_x] & 0xE0 ) >> 5 );
            index_voice2_x++;
        }
        else
        {
            data_index2 = 0x1C;
        }
        index_voice2_y--;

        parse_voice1( data_index1 );
        parse_voice2( data_index2 );

        printf( "\n" );
        timer_global++;
    }

    return EXIT_SUCCESS;
}

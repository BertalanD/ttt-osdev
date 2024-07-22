#include <stdio.h>

bool multiple_of_ten(int num)
{
}

#define CHECK(num) printf(#num " 10-zel oszthato? %s\n", multiple_of_ten(num) ? "igen" : "nem")

int main()
{
    CHECK(1);
    CHECK(10);
    CHECK(15);
    CHECK(2020);
    CHECK(2024);
    return 0;
}

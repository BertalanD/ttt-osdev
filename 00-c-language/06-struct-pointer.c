#include <stdio.h>

struct Foo
{
    int x;
    int y;
};

void access_value(struct Foo f)
{
}

void access_ptr(struct Foo* f)
{
}

int main()
{
    struct Foo f;
    f.x = 42;
    f.y = 13;

    printf("%d %d\n", f.x, f.y);

    access_value(f);
    printf("%d %d\n", f.x, f.y);

    access_ptr(&f);
    printf("%d %d\n", f.x, f.y);

    return 0;
}

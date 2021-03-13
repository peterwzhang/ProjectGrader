#include <iostream>
using namespace std;
// This program "should" print out the array "a" in order.
// This program has one line (line 9) wrong on purpose.
int main(){
    int a[5] = {1,2,3,4,5};
    for (int i = 0; i < 4; i++)
        cout << a[i] << endl;
    cout << a[4] << endl;
}
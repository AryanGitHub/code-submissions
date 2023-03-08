#include <iostream>
using namespace std;

class Solution {
public:
    static int someFunction(string args) {
	return 0;        
    }
};

int main(){

    int a=0;
    cout << Solution::someFunction("Hello, World!");
    return 0;
}

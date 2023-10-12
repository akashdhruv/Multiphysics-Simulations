// C++ program to create an empty 
// treeor and push values one
// by one.
#include <iostream>
#include <AMReX_Vector.H>
#include <AMReX_DistributionMapping.H>

using namespace std;
  
int main()
{

    // Create an empty treeor
    amrex::Vector<int> tree; 
 
    tree.push_back(0);
    tree.push_back(1);
    tree.push_back(2);
    tree.push_back(3);
    tree.push_back(4);
    tree.push_back(5);
    tree.push_back(6);
    tree.push_back(7);
    tree.push_back(8);
    tree.push_back(9);
    tree.push_back(10);
    tree.push_back(11);
    tree.push_back(12);
    tree.push_back(13);
    tree.push_back(14);
    tree.push_back(15);

    int ltree = tree.size();
    cout << ltree << "\n";

    int nprocs = 3;

    int div = int(ltree)/nprocs;
    int mod = ltree%nprocs;

    cout << div << "," << mod << "\n";

}

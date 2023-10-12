// C++ program to create an empty 
// pmapor and push values one
// by one.
#include <iostream>
#include <AMReX_Vector.H>
#include <AMReX_DistributionMapping.H>

using namespace std;
  
int main()
{
    // Create an empty vector
    amrex::Vector<int> pmap;
 
    pmap.push_back(0);
    pmap.push_back(0);
    pmap.push_back(0);
    pmap.push_back(0);
    pmap.push_back(1);
    pmap.push_back(1);
    pmap.push_back(1);
    pmap.push_back(1);
    pmap.push_back(2);
    pmap.push_back(2);
    pmap.push_back(2);
    pmap.push_back(2);

    for (int x : pmap) 
       cout << x << " ";
 
    amrex::DistributionMapping dm;
    dm.define(pmap);

    return 0;
}

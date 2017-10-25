#include <iostream>
#include <string>

int Partition(int a[], int left, int right)
{
      int pivot = a[left];
      while (true)
      {
	 while(a[left] < pivot)
            left++;
            while (a[right] > pivot)
            right--;

 	  if (left < right)
           {

             int temp = a[right];
	     a[right] = a[left];
             a[left] = temp;
	   }
	 else
          {
	        return right;
	  }
      }
}
void QuickSort(int *arr, int left, int right)
{
if(left < right)
 {
       int pivot = Partition(arr, left, right);
       if(pivot > 1)
            QuickSort(arr, left, pivot - 1);
       if(pivot + 1 < right)

          QuickSort(arr, pivot + 1, right);
 }
}
void QuickSort(int *arr, int len)
{
    QuickSort(arr, 0, len - 1);
}
int main()
{
    int max;
    std::cout << "\nProgram for Ascending order of Numeric Values using QUICK SORT";
    std::cout << "\n\nEnter the total number of elements: ";
    std::cin >> max;   
    int *numarray = new int[max];

   for(int i = 0; i < max; i++)
   {
      std::cout << "\nEnter [" << i + 1 << "] element: ";
      std::cin >> numarray[i];
   }
     std::cout << "Before Sorting   : ";
     for(int k = 0; k < max; k++)
       std::cout << numarray[k] << " ";
       std::cout << "\n";
       QuickSort(numarray,max);
    std::cout << "\n\nThe numbers in ascending orders are given below:\n\n";
    for(int i = 0; i < max; i++)
    {
	std::cout << "Sorted [" << i + 1 << "] element: ";
	std::cout << numarray[i];
        std::cout << "\n";

    }
   delete [] numarray;
  return 0;
 }

/***************output*******

bash-4.1$ g++ q1.cpp
bash-4.1$ ./a.out
Program for Ascending order of Numeric Values using QUICK SORT
Enter the total number of elements: 5
Enter [1] element: 20
Enter [2] element: 4
Enter [3] element: 6
Enter [4] element: 8
Enter [5] element: 21
Before Sorting   : 20 4 6 8 21 
The numbers in ascending orders are given below:
Sorted [1] element: 4
Sorted [2] element: 6
Sorted [3] element: 8
Sorted [4] element: 20
Sorted [5] element: 21


*/
 


#include <iostream>
#include <string>
#include <sstream>
#include <iterator>
#include <algorithm>
#include <vector>
#include <cstdio>
#include <cstdlib>
#include <numeric>

int main()
{
	std::string input;
	std::getline (std::cin, input);

	// http://stackoverflow.com/questions/5607589/right-way-to-split-an-stdstring-into-a-vectorstring
	std::stringstream ss(input);
	std::istream_iterator<std::string> begin(ss);
	std::istream_iterator<std::string> end;
	std::vector<std::string> vstrings(begin, end);

	std::vector<int> numbers(vstrings.size(), 0);
	for(int i = 0 ; i < vstrings.size() ; ++i) {
		int num = std::stoi(vstrings[i], nullptr, 10);
		numbers[i] = num;
	}

	int sum = std::accumulate(numbers.begin(), numbers.end(), 0);
	printf("%d\n", sum);
	return 0;
}

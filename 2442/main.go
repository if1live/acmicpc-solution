package main

import "fmt"

func main() {
	var count = 0
	fmt.Scanf("%d", &count)

	for i := 0; i < count; i++ {
		var starCount = i * 2 + 1
		var spaceCount = count - i - 1
		for j := 0; j < spaceCount; j++ {
			fmt.Printf(" ")
		}
		for j := 0; j < starCount; j++ {
			fmt.Printf("*")
		}
		fmt.Printf("\n")
	}
}

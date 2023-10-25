package main

import (
	"fmt"
	"runtime/debug"
)

func main() {
	prev := debug.SetGCPercent(0)

	fmt.Println(prev)

	debug.SetGCPercent(prev)
}

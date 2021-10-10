pod:
	pod install --repo-update

lint:
	./Pods/SwiftLint/swiftlint autocorrect
gen:
	./Pods/SwiftGen/bin/swiftgen
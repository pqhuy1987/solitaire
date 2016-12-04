

/* Synthesize Singleton For Class
 *
 * Creates a singleton interface for the specified class with the following methods:
 *
 * + (MyClass*) shared;
 *
 * Calling shared will instantiate the class and swizzle some methods to ensure
 * that only a single instance ever exists.
 *
 * Usage:
 *
 * MyClass.h:
 * ========================================
 *    #import "BZSingleton.h"
 *
 *    @interface MyClass: SomeSuperclass
 *    {
 *        ...
 *    }
 *    BZ_SINGLETON_FOR_CLASS_DECLARE(MyClass);
 *
 *    @end
 * ========================================
 *
 *    MyClass.m:
 * ========================================
 *    #import "MyClass.h"
 *
 *    @implementation MyClass
 *
 *    BZ_SINGLETON_FOR_CLASS_SYNTHESIZE(MyClass);
 *
 *    ...
 *
 *    @end
 * ========================================
 *
 *
 * Note: Calling alloc manually will also initialize the singleton, so you
 * can call a more complex init routine to initialize the singleton like so:
 *
 * [[MyClass alloc] initWithParam:firstParam secondParam:secondParam];
 *
 * Just be sure to make such a call BEFORE you call "sharedInstance" in
 * your program.
 */

#import <objc/runtime.h>

#define BZ_SINGLETON_FOR_CLASS_WITH_ACCESSOR_DECLARE(classname, accessorMethodName) \
+ (classname *)accessorMethodName;

#if __has_feature(objc_arc)
	#define BZ_SINGLETON_SYNTHESIZE_RETAIN_METHODS
#else
	#define BZ_SINGLETON_SYNTHESIZE_RETAIN_METHODS \
	- (id)retain \
	{ \
		return self; \
	} \
	 \
	- (NSUInteger)retainCount \
	{ \
		return NSUIntegerMax; \
	} \
	 \
	- (oneway void)release \
	{ \
	} \
	 \
	- (id)autorelease \
	{ \
		return self; \
	}
#endif

#define BZ_SINGLETON_FOR_CLASS_WITH_ACCESSOR_SYNTHESIZE(classname, accessorMethodName) \
 \
static classname *accessorMethodName##Instance = nil; \
 \
+ (classname *)accessorMethodName \
{ \
	@synchronized(self) \
	{ \
		if (accessorMethodName##Instance == nil) \
		{ \
			accessorMethodName##Instance = [super allocWithZone:NULL]; \
			accessorMethodName##Instance = [accessorMethodName##Instance init]; \
			method_exchangeImplementations(\
				class_getClassMethod([accessorMethodName##Instance class], @selector(accessorMethodName)),\
				class_getClassMethod([accessorMethodName##Instance class], @selector(BZ_lockless_##accessorMethodName)));\
			method_exchangeImplementations(\
				class_getInstanceMethod([accessorMethodName##Instance class], @selector(init)),\
				class_getInstanceMethod([accessorMethodName##Instance class], @selector(BZ_onlyInitOnce)));\
		} \
	} \
	 \
	return accessorMethodName##Instance; \
} \
 \
+ (classname *)BZ_lockless_##accessorMethodName \
{ \
	return accessorMethodName##Instance; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
	return [self accessorMethodName]; \
} \
 \
- (id)copyWithZone:(NSZone *)zone \
{ \
	return self; \
} \
- (id)BZ_onlyInitOnce \
{ \
	return self;\
} \
 \
BZ_SINGLETON_SYNTHESIZE_RETAIN_METHODS

#define BZ_SINGLETON_FOR_CLASS_DECLARE(classname) BZ_SINGLETON_FOR_CLASS_WITH_ACCESSOR_DECLARE(classname, shared)
#define BZ_SINGLETON_FOR_CLASS_SYNTHESIZE(classname) BZ_SINGLETON_FOR_CLASS_WITH_ACCESSOR_SYNTHESIZE(classname, shared)

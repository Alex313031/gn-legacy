#ifndef TEST_LINUX_STATIC_HELLO_SHARED_H_
#define TEST_LINUX_STATIC_HELLO_SHARED_H_

#if defined(HELLO_SHARED_IMPLEMENTATION)
 #define HELLO_EXPORT __attribute__((visibility("default")))
 #define HELLO_EXPORT_PRIVATE __attribute__((visibility("default")))
#else
 #define HELLO_EXPORT
 #define HELLO_EXPORT_PRIVATE
#endif  // defined(HELLO_SHARED_IMPLEMENTATION)

HELLO_EXPORT const wchar_t* GetSharedText();

#endif  // TEST_LINUX_STATIC_HELLO_SHARED_H_

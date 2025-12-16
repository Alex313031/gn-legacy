// {{NO_DEPENDENCIES}}
// For #define-ing static resources for resource script file(s).
// Used by resource.rc

// Icons
#define IDI_HELLOWORLD              101
#define IDI_SMALL                   102
#define IDI_ABOUT                   104

// Main application resource
#define IDC_HELLOWORLD              103

// Dialogs
#define IDD_ABOUT_DIALOG            105
#define IDD_ABOUTBOX                106

// Menu items
#define IDM_ABOUT                   200
#define IDM_EXIT                    201
#define IDM_HELP                    202

// Text box
#define IDC_TEXT1                   300

// For resources to be loaded without an ID from the system.
#ifndef IDC_STATIC
 #define IDC_STATIC                -1
#endif // IDC_STATIC

// For importing .manifest in .rc file
#define APP_MANIFEST                1

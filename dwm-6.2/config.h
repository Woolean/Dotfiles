/* See LICENSE file for copyright and license details. */

#include "X11/XF86keysym.h"

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const int user_bh            = 0;        /* 0 means that dwm will calculate     bar height, >= 1 means dwm will user_bh as bar height */
static const char *fonts[]          = {"Siji:size=17", "Six Eight Zero Nine Chargen:size=9" };
static const char dmenufont[]       = "Six Eight Zero Nine Chargen:size=11:style=thin";
static const char col_gray1[]       = "#141b1e";
static const char col_gray2[]       = "#232a2d";
static const char col_gray3[]       = "#dadada";
static const char col_gray4[]       = "#6cbfbf";
static const char col_cyan[]        = "#67b0e8";
static const char col_darkpurple[]  = "#c47fd5";
//static const char col_gray1[]       = "#1d2021";
//static const char col_gray2[]       = "#282828";
//static const char col_gray3[]       = "#ebdbb2";
//static const char col_gray4[]       = "#83a598";
//static const char col_cyan[]        = "#076678";
//static const char col_darkpurple[]  = "#b16286";


static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_darkpurple, col_gray1,  col_darkpurple },
};

//static const char *colors[][3]      = {
//	/*               fg         bg         border   */
//	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
//	[SchemeSel]  = { col_gray1, col_cyan,  col_darkpurple },
//};

/* tagging */
//static const char *tags[] = { "一", "二", "三", "四", "五", "六", "七", "八", "九" };
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
    /* class     instance  title           tags mask  isfloating  monitor */
    { "Gimp",    NULL,     NULL,           0,         1,               -1 },
    { "firefox", NULL,     NULL,           0,    0,               -1 },
    { "mpv", NULL, NULL, 0, 1, -1},
    { "Pavucontrol", NULL,	  NULL,		   1 << 9,	  1,		       -1 },
    { "zoom", NULL,	  NULL,		   1 << 9,	  1,		       -1 },
    };

/* layout(s) */
static const float mfact     = 0.50; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */

#include "layouts.c"
#include "fibonacci.c"
static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[@]",      spiral },
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
 	{ "[\\]",      dwindle },
	{ "HHH",	grid}, 
	{ NULL,			NULL },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-i", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_darkpurple, "-sf", col_gray1, NULL };
//static const char *termcmd[]  = { "kitty", NULL };
static const char *termcmd[]  = { "urxvt", NULL };
static const char *browsercmd[] = {"/home/woolean/.local/bin/brave-shortcut", NULL};
static const char *pavucontrolcmd[] = {"pavucontrol", NULL};
static const char *pcmanfmcmd[] = {"pcmanfm", NULL};
static const char *screenshootercmd[] = {"xfce4-screenshooter", NULL};
static const char *spotifycmd[] = {"spotify", NULL};
static const char *playcmd[]       = { "playerctl", "play-pause", NULL };
static const char *prevcmd[]       = { "playerctl", "previous", NULL };
static const char *nextcmd[]       = { "playerctl", "next", NULL };
static const char *stopcmd[]      = { "playerctl", "stop", NULL };
static const char *upvol[]   = { "/usr/bin/pactl", "set-sink-volume", "0", "+5%",     NULL };
static const char *downvol[] = { "/usr/bin/pactl", "set-sink-volume", "0", "-5%",     NULL };
static const char *mutevol[] = { "/usr/bin/pactl", "set-sink-mute",   "0", "toggle",  NULL };

static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY,			            XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY|ShiftMask,             XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_q,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_r,      setlayout,      {.v = &layouts[3]} },
	{ MODKEY|ShiftMask,             XK_r,      setlayout,      {.v = &layouts[4]} },
	{ MODKEY,			XK_g,	   setlayout,	   {.v = &layouts[5]} },
    { MODKEY|ControlMask,           XK_less,   cyclelayout,    {.i = -1 } },
    { MODKEY|ControlMask,           XK_greater,cyclelayout,    {.i = +1 } },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_e,      quit,           {0} },
	{ MODKEY|ShiftMask,				XK_b,	   spawn,		   {.v = browsercmd } },
	{ MODKEY,						XK_n,	   spawn,		   {.v = pcmanfmcmd } },
	{ MODKEY,						XK_u,  spawn,		   {.v = screenshootercmd} },
	{ MODKEY,						XK_y,      spawn,		   {.v = pavucontrolcmd} },
	{ 0,							XF86XK_Tools, spawn,		   {.v = spotifycmd} },	
	{ 0,                            0x1008ff14,          spawn,            {.v = playcmd } },
    { 0,                            0x1008ff16,          spawn,            {.v = prevcmd } },
    { 0,                            0x1008ff17,          spawn,            {.v = nextcmd } },
    { 0,                            0x1008ff15,          spawn,            {.v = stopcmd } },
	{ 0,							XF86XK_AudioLowerVolume, spawn, {.v = downvol } },
	{ MODKEY,						XK_F12, spawn,		{.v = mutevol } },
	{ 0,							XF86XK_AudioRaiseVolume, spawn, {.v = upvol   } },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};


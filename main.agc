// ASTEROID BELT
// Created by John Daudelin
// BottleApp Games 2012
// Modified December, 2017

Print ("Loading...")
sync()

SetVirtualResolution (480,320)
SetSyncRate (60,1)
SetOrientationAllowed (0,0,1,1)

Menu()

function Menu()
	// Sprites 143-148 are old stars
	DIM stars[6]
	DIM StarIncrease[6]

	Backdrop = (CreateSprite (0))
	SetSpriteColor (Backdrop,32,32,32,0)

	CountTime = 0
	Shatter = 0

	scale# = 1

	starImage = LoadImage ("Star.png")

	for i = 0 to 5
		scale# = scale# - .1
		stars[i] = CreateSprite (starImage)
		SetSpriteScale (stars[i],scale#,scale#)
		SetSpriteColor (stars[i],255,255,255,Random (10,255))
	next i

	SetSpritePosition (stars[0],240,280)
	SetSpritePosition (stars[1],70,100)
	SetSpritePosition (stars[2],30,230)
	SetSpritePosition (stars[3],200,40)
	SetSpritePosition (stars[4],350,200)
	SetSpritePosition (stars[5],430,300)

	LoadImage (3,"Asteroid1.png")
	LoadImage (4,"Asteroid2.png")
	LoadImage (5,"Asteroid3.png")
	LoadImage (7,"company.png")
	LoadImage (10, "SoundOn.png")
	LoadImage (9,"SoundOff.png")
	LoadMusic (1,"Space.mp3")
	LoadSound (2,"rumbling 2.wav")
	LoadSound (3,"beep 04.wav")

	CreateSprite (1, LoadImage ("PlayButton.png"))
	SetSpritePosition (1,170,100)
	SetSpriteColorAlpha (1,0)

	CreateSprite (2, LoadImage ("Help.png"))
	SetSpritePosition (2,170,160)
	SetSpriteColorAlpha (2,0)

	CreateSprite (3, 10)
	SetSpritePosition (3,0,280)
	SetSpriteScale (3,.8,.8)
	SetSpriteColorAlpha (3,0)

	CreateSprite (21, LoadImage ("Exit.png"))
	SetSpritePosition (21,170,220)
	SetSpriteColorAlpha (21,0)

	scale# = .5

	for something = 4 to 9
		CreateSprite (something,Random (3,5))
		SetSpriteScale (something,scale#,scale#)

		scale# = scale# + .1
		Sideways = Random (1,2)
		Upwards = Random (0,320)
		if Sideways = 1
			SetSpriteX (something,Random (-80,-42))
		else
			SetSpriteX (something,Random (480,520))
		endif
		SetSpriteY (something,Upwards)

		SetSpriteAngle (something,Random (0,360))
	next something

	CreateSprite (10, LoadImage ("Title.png"))
	SetSpritePosition (10,50,0)
	SetSpriteColorAlpha (10,0)

	CreateSprite (15, LoadImage ("HelpScreen2.png"))
	SetSpriteColorAlpha (15,0)

	CreateSprite (20, LoadImage ("MenuButton.png"))
	SetSpritePosition (20,190,280)
	SetSpriteColorAlpha (20,0)

	CreateSprite (16, LoadImage ("company.png"))
	SetSpritePosition (16,350,275)



	for g = 1 to 6
		StarIncrease [g]= Random (0,1)
	next g

	PlayMusic (1,1)

	quickwait = 0
	while quickwait < 51
		SetSpriteColorAlpha (1,GetSpriteColorAlpha (1)+5)
		SetSpriteColorAlpha (2,GetSpriteColorAlpha (2)+5)
		SetSpriteColorAlpha (3,GetSpriteColorAlpha (3)+5)
		SetSpriteColorAlpha (10,GetSpriteColorAlpha (10)+5)
		SetSpriteColorAlpha (21,GetSpriteColorAlpha (21)+5)
		SetSpriteColorAlpha (Backdrop,GetSpriteColorAlpha (Backdrop)+5)

		quickwait = quickwait + 1

		sync ()
	endwhile

	Do
		x = 0
		sync ()

		for h = 143 to 148
			if StarIncrease [h - 142]=1
				SetSpriteColorAlpha (h,GetSpriteColorAlpha (h)+1)
				if GetSpriteColorAlpha (h)=>255
					StarIncrease [h-142]=0
				endif
			endif
			if StarIncrease [h - 142]=0
				SetSpriteColorAlpha (h,GetSpriteColorAlpha (h)-1)
				if GetSpriteColorAlpha (h)=<0
					StarIncrease [h-142]=1
				endif
			endif
		next h

		if Shatter = 1
			while CountTime < 90
				for v = 11 to 14
					x# = cos(GetSpriteAngle(v))
					y# = sin(GetSpriteAngle(v))

					SetSpritePosition(v,GetSpriteX(v)-7*x#,GetSpriteY(v)-7*y#)
				next v
				sync ()
				CountTime = CountTime + 1
			endwhile
			exit
		endif

		If GetPointerPressed ()=1

		// Pressing the Play Button

		If GetSpriteExists (1)=1
			if GetSpriteHitTest(1,GetPointerX(),GetPointerY())=1
				CreateSprite (11, LoadImage ("Shatter1.png"))
				CreateSprite (12, LoadImage ("Shatter2.png"))
				CreateSprite (13, LoadImage ("Shatter3.png"))
				CreateSprite (14, LoadImage ("Shatter4.png"))

				for h = 11 to 14
					SetSpritePosition (h,210,100)
					SetSpriteAngle (h,angle)
					angle = angle + 78
				next h
				
				PlaySound (2)
				DeleteSprite (1)
				Shatter = 1
			endif
		endif

		// Pressing the Help Button
			if GetSpriteHitTest(2,GetPointerX(),GetPointerY())=1
				if GetSpriteImageId (3)=10
					playSound (3)
				endif
				SetSpriteColoralpha (2,0)
				do
					sync()
					if GetSpriteColorAlpha (15)<255
						SetSpriteColorAlpha (15,GetSpriteColorAlpha (15)+5)
					endif
					if GetPointerPressed ()=1 and GetSpriteHitTest (20,GetPointerX(),GetPointerY())
						if GetSpriteImageId (3)=10
							playSound (3)
						endif
						SetSpriteColorAlpha (2,255)
						do
							SetSpriteColorAlpha (15,GetSpriteColorAlpha (15)-5)
							SetSpriteColorAlpha (20,0)
							sync ()
							if GetSpriteColorAlpha (15)=0
								exit
							endif
						loop
						exit
					endif
					if GetSpriteColorAlpha (15)=255
						if GetSpriteColorAlpha (20)<255
							SetSpriteColorAlpha (20,GetSpriteColorAlpha (20)+5)
						endif
					endif
				loop
			endif

			if GetSpriteHitTest (21,GetPointerX(),GetPointerY())=1
				end
			endif
		endif
		If GetPointerPressed()=1 and GetSpriteHitTest(3,GetPointerX(),GetPointerY())=1
			if GetSpriteImageID (3)=10
				SetSpriteImage (3,9)
				SetSpriteScale (3,.8,.8)
				SetMusicSystemVolume (0)
				x = 1
			endif
			If GetSpriteImageID (3)=9 and x = 0
				SetSpriteImage (3,10)
				SetSpriteScale (3,.8,.8)
				SetMusicSystemVolume (100)
			endif
		endif
		for v = 4 to 9
			x# = cos(GetSpriteAngle(v))
			y# = sin(GetSpriteAngle(v))

			SetSpritePosition(v,GetSpriteX(v)-1*x#,GetSpriteY(v)-1*y#)

			if GetSpriteX(v)>480
				SetSpriteX(v,-40)
			endif
			if GetSpriteX(v)<-40
				SetSpriteX(v,480)
			endif
			If GetSpriteY(v)>320
				SetSpriteY(v,-40)
			endif
			If GetSpriteY(v)<-40
				SetSpriteY(v,320)
			endif
		next v
	loop

	If GetSpriteImageId (3)=10
		sound = 1
	endif
	if GetSpriteImageId (3)=9
		sound = 0
	endif

	for g = 1 to 4
		if GetSpriteExists (g)=1
			DeleteImage (g)
			DeleteSprite (g)
		endif
	next g

	DeleteSprite (Backdrop)

	DeleteText (1)

	Gosub Replay
endfunction

//Game
Replay:

level = 1
score = 1000
lives = 3
numbertokeeptrack = 0
B = 0
A = 0
Asteroid = 0
x = 0
h# = 0
Turn# = 0
accel# = 0
t# = 0
g# = 0
x# = 0
y# = 0
ty = 0
scores = 0
coin = 2500
Bonus = 0
alpha = 0
goalangle# = 0
increase# = 0
direction = 0
traveling = 3
Spinning = 0
KeepTrack = 0
small = 0
smallwait = 0
if level = 1
    addlife1 = 0
    addlife2 = 0
    addlife3 = 0
    addlife4 = 0
    addlife5 = 0
    addlife6 = 0
endif

for delete = 1 to 3000
    if GetSpriteExists (delete)=1
        DeleteSprite (delete)
    endif
    if GetTextExists (delete)=1
        DeleteText (delete)
    endif
    if GetImageExists (delete)=1
        DeleteImage (delete)
    endif
    if GetSoundExists (delete)=1
        DeleteSound (delete)
    endif
next delete

DeleteParticles (1)
DeleteParticles (2)
DeleteParticles (3)

backdrop1 = CreateSprite (LoadImage ("Background1.png"))

DIM Bullet# [9,4]
DIM AlienBullet# [9,3]

LoadImage (7,"ship1.png")
LoadImage (2,"Asteroid1.png")
LoadImage (3,"Asteroid2.png")
LoadImage (4,"Bullet.png")
LoadImage (5,"Pause.png")
LoadImage (6,"Play.png")
LoadSound (1,"laser.wav")
LoadSound (2,"Shoot.wav")
LoadSound (3,"explode3.wav")
LoadSound (4,"Collect.wav")
LoadSound (5,"Beep.wav")
LoadImage (8,"Asteroid3.png")
LoadImage (10,"Title.png")
LoadImage (11,"S1.png")
LoadImage (12,"S2.png")
LoadImage (13,"S3.png")
LoadImage (14,"Replay.png")
LoadImage (18,"Coin.png")
LoadImage (500,"shrapnel3.png")
LoadImage (501,"particle.png")
LoadSound (6,"sweep 03.wav")
LoadImage (64,"Continue.png")
LoadImage (81,"Star.png")
LoadImage (82,"Accelerate.png")
LoadImage (83,"UFO.png")
LoadImage (84,"UFO2.png")
LoadSound (9,"spac.wav")
LoadSound (10,"Hit.wav")
LoadImage (85,"AlienBullet.png")
LoadSound (11,"industrial alarm.wav")
LoadImage (86,"Lives3.png")
LoadImage (87,"Lives2.png")
LoadImage (88,"Lives1.png")
LoadImage (89,"Lives4.png")
LoadImage (90,"Lives5.png")
LoadImage (91,"Lives6.png")
LoadSound (18,"booms1.wav")
LoadSound (19,"electro 02.wav")
LoadImage (92,"ExtraLife.png")
loadSound (20,"beep 04.wav")
LoadImage (157,"Exit.png")
LoadImage (158,"Resume.png")
LoadImage (2004,"Exit2.png")

if level >1
    PlaySound (20)
endif

if level = 1
    LoadImage (73,"Level1.png")
endif
if level = 2
    SetSpriteImage (backdrop1,LoadImage ("Background2.png"))
    LoadImage (73,"Level2.png")
    Bonus = 1000
endif
if level = 3
    SetSpriteImage (backdrop1,LoadImage ("Background3.png"))
    Bonus = 2000
    LoadImage (73,"Level3.png")
endif
if level = 4
    SetSpriteImage (backdrop1,LoadImage ("Background4.png"))
    Bonus = 3000
    LoadImage (73,"Level4.png")
endif
if level = 5
    SetSpriteImage (backdrop1,LoadImage ("Background5.png"))
    Bonus = 4000
    LoadImage (73,"Level5.png")
endif
if level = 6
    SetSpriteImage (backdrop1,LoadImage ("Background6.png"))
    Bonus = 5000
    LoadImage (73,"Level6.png")
endif
if Level = 7
    SetSpriteImage (backdrop1,LoadImage ("Background7.png"))
    Bonus = 6000
    LoadImage (73,"Level7.png")
endif
if Level > 7
    Bonus = (Level*1000) - 1000
    if Level = 15
        CreateText (500,"Congratulations! You have rocketed your")
        CreateText (501,"way through the entire galaxy, surviving")
        CreateText (502,"ALL the dangerous asteroids! Check for more")
        CreateText (503,"games like Asteroid Belt at")
        CreateText (504,"www.BottleAppGames.com")
        SetTextAlignment (500,1)
        SetTextAlignment (501,1)
        SetTextAlignment (502,1)
        SetTextAlignment (503,1)
        SetTextAlignment (504,1)
        SetTextPosition (500,240,100)
        SetTextPosition (501,240,130)
        SetTextPosition (502,240,160)
        SetTextPosition (503,240,190)
        SetTextPosition (504,240,220)
        SetTextColor (500,72,254,68,255)
        SetTextColor (501,72,254,68,255)
        SetTextColor (502,72,254,68,255)
        SetTextColor (503,72,254,68,255)
        SetTextColor (504,72,254,68,255)
        SetTextSize (500,17)
        SetTextSize (501,17)
        SetTextSize (502,17)
        SetTextSize (503,17)
        SetTextSize (504,20)
        do
            sync()
        loop
    endif
    if Mod(Level, 8) = 0
        SetSpriteImage (backdrop1,LoadImage ("Background1.png"))
        LoadImage (73,"Level8.png")
    endif
    if Mod(Level, 9) = 0
        SetSpriteImage (backdrop1,LoadImage ("Background2.png"))
        LoadImage (73,"Level9.png")
    endif
    if Mod(Level, 10) = 0
        SetSpriteImage (backdrop1,LoadImage ("Background3.png"))
        LoadImage (73,"Level10.png")
    endif
    if Mod(Level, 11) = 0
        SetSpriteImage (backdrop1,LoadImage ("Background4.png"))
        LoadImage (73,"Level11.png")
    endif
    if Mod(Level, 12) = 0
        SetSpriteImage (backdrop1,LoadImage ("Background5.png"))
        LoadImage (73,"Level12.png")
    endif
    if Mod(Level, 13) = 0
        SetSpriteImage (backdrop1,LoadImage ("Background6.png"))
        LoadImage (73,"Level13.png")
    endif
    if Mod(Level, 14) = 0
        SetSpriteImage (backdrop1,LoadImage ("Background7.png"))
        LoadImage (73,"Level14.png")
    endif
endif

scale# = 1

for strs = 143 to 148
    scale# = scale# - .1
    CreateSprite (strs,81)
    SetSpritePosition (strs,Random (10,470),Random (10,310))
    SetSpriteScale (strs,scale#,scale#)
    SetSpriteColor (strs,255,255,255,Random (10,255))
next strs

SetSpritePosition (143,240,280)
SetSpritePosition (144,70,100)
SetSpritePosition (145,30,230)
SetSpritePosition (146,200,40)
SetSpritePosition (147,350,200)
SetSpritePosition (148,430,300)

for bullets = 1 to 9
    Bullet# [bullets,1] = 0
    CreateSprite (bullets + 200,4)
    SetSpritePosition (bullets + 200,210,210)
    SetSpriteScale (bullets + 200,.2,.2)
next bullets

for AB = 1 to 9
    AlienBullet# [AB,1] = 0
    CreateSprite (AB + 230,85)
    SetSpritePosition (AB + 230,1000,1000)
    SetSpriteScale (AB + 230,.2,.2)
next AB

if level <8
    asteroids = level + 2
    asteroid = level + 2
endif
if level >7
    asteroids = 9
    asteroid = 9
endif

a = 1

score = score + Bonus

for g = 2 to asteroids
    CreateSprite (g,2)
    SetSpriteShape (g,3)
    SetSpriteAngle (g,random (1,360))
    a = a + 1
next g

for h = 2 to asteroids
    SetSpriteX (h,random(0,539)-35)
    if GetSpriteX(h)<20 or GetSpriteX(h)>460
        SetSpriteY (h,random(0,360)-35)
    endif
    if GetSpriteX(h)>20 and GetSpriteX(h)<460
        r = random (1,2)
        if r = 1
            SetSpriteY (h,random(0,55)-35)
        endif
        if r = 2
            SetSpriteY (h,random(300,325))
        endif
    endif
next h

CreateSprite (100,5)
SetSpritePosition (100,0,0)
SetSpriteScale (100,.5,.5)

CreateSprite (101,10)
SetSpritePosition (101,5,110)
SetSpriteScale (101,1.2,1.2)
SetSpriteColorAlpha (101,0)

CreateSprite (102,82)
SetSpritePosition (102,190,270)
SetSpriteScale (102,.5,.5)

CreateSprite (92,92)
SetSpriteScale (92,.6,.6)
SetSpritePosition (92,400,10)
SetSpriteColorAlpha (92,0)
SetSpriteAngle (92,20)

CreateText (2,str (score))
SetTextSize (2,20)
SetTextAlignment (2,2)
SetTextPosition (2,480,0)
SetTextColor (2,72,254,68,255)

CreateSprite (73,73)
SetSpritePosition (73,125,100)

CreateSprite (157,157)
SetSpritePosition (157,100,180)
SetSpriteColorAlpha (157,0)
SetSpriteScale (157,.9,.9)

CreateSprite (158,158)
SetSpritePosition (158,230,180)
SetSpriteColorAlpha (158,0)
SetSpriteScale (158,.9,.9)

Gosub Continuing

Continuing:

CreateParticles (1,-1000,1000)
CreateParticles (2,-1000,1000)
CreateParticles (3,-1000,-1000)
SetParticlesImage (3,501)
SetParticlesLife (3,.5)
SetParticlesFrequency (3,50)
SetParticlesSize (3,10)
SetParticlesDirection (3,50,50)
SetParticlesAngle (3,360)
AddParticlesColorKeyFrame (3,0,0,0,0,0)
AddParticlesColorKeyFrame (3,.4,0,255,0,255)
AddParticlesColorKeyFrame (3,.4,0,255,0,255)
AddParticlesColorKeyFrame (3,.5,0,0,0,0)

CreateSprite (1,7)
SetSpritePosition (1,210,150)
SetSpriteScale (1,.2,.2)
SetSpriteShape (1,3)

if numbertokeeptrack = 1
    SetSpriteColorAlpha (1,25)
endif

if GetSpriteExists (103)=1
    DeleteSprite (103)
endif

if lives = 6
    CreateSprite (103,91)
    SetSpritePosition (103,215,0)
    SetSpriteScale (103,.5,.5)
endif
if lives = 5
    CreateSprite (103,90)
    SetSpritePosition (103,215,0)
    SetSpriteScale (103,.5,.5)
endif
if lives = 4
    CreateSprite (103,89)
    SetSpritePosition (103,215,0)
    SetSpriteScale (103,.5,.5)
endif
if lives = 3
    CreateSprite (103,88)
    SetSpritePosition (103,215,0)
    SetSpriteScale (103,.5,.5)
endif
if lives = 2
    CreateSprite (103,87)
    SetSpritePosition (103,215,0)
    SetSpriteScale (103,.5,.5)
endif
if lives = 1
    CreateSprite (103,86)
    SetSpritePosition (103,215,0)
    SetSpriteScale (103,.5,.5)
endif

smallwait = 0
goalangle# = 0
increase# = 0
havefun = 2
accel# = 0
text = 56
KeepTrack = 1
time2 = 0

do
    if time2 = 100
        SetSpriteColorAlpha (1,255)
    endif
    if time2 < 100
        time2 = time2 + 1
        if Mod(time2, 5) = 0 and GetSpriteColorAlpha(1) = 25
            SetSpriteColorAlpha (1,199)
        endif
        if Mod(time2, 5) = 0 and GetSpriteColorAlpha (1)=200
            SetSpriteColorAlpha (1,25)
        endif
        if GetSpriteColorAlpha (1)=199
            SetSpriteColorAlpha (1,200)
        endif
    endif
    if GetSpriteColorAlpha (92)>0
        SetSpriteColorAlpha (92,GetSpriteColorAlpha (92)-3)
        if GetSpriteColorAlpha (92)>200
            SetParticlesPosition (3,425,15)
        endif
    endif
    if GetSpriteColorAlpha (92)<200
        SetParticlesPosition (3,-1000,-1000)
    endif
    if level <8
        if Mod(KeepTrack, 800) = 0
            Sideways = Random (1,2)
            CreateSprite (83,83)
            SetSpriteScale (83,.1,.1)
            SetSpriteShape (83,3)
            if Sideways = 1
                SetSpritePosition (83,480,Random (1,300))
            endif
            if Sideways = 2
                SetSpritePosition (83,-35,Random (1,300))
            endif
			playsound (9,100,1)
        endif
    endif
    if level > 7
        modthing = 800 - (level*50)
        if Mod(KeepTrack, modthing) = 0
            if GetSpriteExists (83)=0
                Sideways = Random (1,2)
                CreateSprite (83,83)
                SetSpriteScale (83,.1,.1)
                SetSpriteShape (83,3)
                if Sideways = 1
                    SetSpritePosition (83,480,Random (1,300))
                endif
                if Sideways = 2
                    SetSpritePosition (83,-35,Random (1,300))
                endif
				playsound (9,100,1)
			endif
        endif
    endif
    if score > 10000 and addlife1 = 0
        if GetSpriteExists (103)=1
        if GetSpriteImageId (103)<91
            ThingId = GetSpriteImageId (103)
            DeleteSprite (103)

            CreateSprite (103,ThingId + 1)
            SetSpritePosition (103,215,0)
            SetSpriteScale (103,.5,.5)
        endif
        else
            CreateSprite (103,86)
            SetSpritePosition (103,215,0)
            SetSpriteScale (103,.5,.5)
        endif
        addlife1 = 1
        lives = lives + 1
        SetSpriteColorAlpha (92,255)
        PlaySound (19)
    endif
    if score > 25000 and addlife2 = 0
        if GetSpriteExists (103)=1
        if GetSpriteImageId (103)<91
            ThingId = GetSpriteImageId (103)
            DeleteSprite (103)

            CreateSprite (103,ThingId + 1)
            SetSpritePosition (103,215,0)
            SetSpriteScale (103,.5,.5)
        endif
        else
            CreateSprite (103,86)
            SetSpritePosition (103,215,0)
            SetSpriteScale (103,.5,.5)
        endif
        SetSpriteColorAlpha (92,255)
        addlife2 = 1
        lives = lives + 1
        PlaySound (19)
    endif
    if score > 35000 and addlife3 = 0
        if GetSpriteExists (103)=1
        if GetSpriteImageId (103)<91
            ThingId = GetSpriteImageId (103)
            DeleteSprite (103)

            CreateSprite (103,ThingId + 1)
            SetSpritePosition (103,215,0)
            SetSpriteScale (103,.5,.5)
        endif
        else
            CreateSprite (103,86)
            SetSpritePosition (103,215,0)
            SetSpriteScale (103,.5,.5)
        endif
        addlife3 = 1
        lives = lives + 1
        PlaySound (19)
        SetSpriteColorAlpha (92,255)
    endif
    if score > 50000 and addlife4 = 0
        if GetSpriteExists (103)=1
        if GetSpriteImageId (103)<91
            ThingId = GetSpriteImageId (103)
            DeleteSprite (103)

            CreateSprite (103,ThingId + 1)
            SetSpritePosition (103,215,0)
            SetSpriteScale (103,.5,.5)
            addlife4 = 1
            lives = lives + 1
            PlaySound (19)
            SetSpriteColorAlpha (92,255)
        endif
        else
            CreateSprite (103,86)
            SetSpritePosition (103,215,0)
            SetSpriteScale (103,.5,.5)
            addlife4 = 1
            lives = lives + 1
			PlaySound (19)
            SetSpriteColorAlpha (92,255)
        endif
    endif
    if score > 70000 and addlife5 = 0
        if GetSpriteExists (103)=1
        if GetSpriteImageId (103)<91
            ThingId = GetSpriteImageId (103)
            DeleteSprite (103)

            CreateSprite (103,ThingId + 1)
            SetSpritePosition (103,215,0)
            SetSpriteScale (103,.5,.5)
            addlife5 = 1
            lives = lives + 1
			PlaySound (19)
            SetSpriteColorAlpha (92,255)
        endif
        else
            CreateSprite (103,86)
            SetSpritePosition (103,215,0)
            SetSpriteScale (103,.5,.5)
            addlife5 = 1
            lives = lives + 1
            PlaySound (19)
            SetSpriteColorAlpha (92,255)
        endif
    endif
    if score > 100000 and addlife6 = 0
        if GetSpriteExists (103)=1
        if GetSpriteImageId (103)<91
            ThingId = GetSpriteImageId (103)
            DeleteSprite (103)

            CreateSprite (103,ThingId + 1)
            SetSpritePosition (103,215,0)
            SetSpriteScale (103,.5,.5)
            addlife6 = 1
            lives = lives + 1
            PlaySound (19)
            SetSpriteColorAlpha (92,255)
        endif
        else
            CreateSprite (103,86)
            SetSpritePosition (103,215,0)
            SetSpriteScale (103,.5,.5)
            addlife6 = 1
            lives = lives + 1
            PlaySound (19)
            SetSpriteColorAlpha (92,255)
        endif
    endif
    x = 0
    h# = GetDirectionX()

    SetTextString (2,str (score))
    if GetSpriteImageID (100)=5
        score = score - 1
    endif
    for star = 143 to 148
        If GetSpriteColorAlpha (star)=255
            StarIncrease [star-142]=0
        endif
        if GetSpriteColorAlpha (star)=10
            StarIncrease [star-142]=1
        endif
        if StarIncrease [star - 142]=1
            SetSpriteColorAlpha (star,GetSpriteColorAlpha (star)+1)
        endif
        if StarIncrease [star - 142]=0
            SetSpriteColoralpha (star, GetSpriteColorAlpha (star)-1)
        endif
    next star

    ty = ty + 1

    if ty > 30 and GetSpriteColorAlpha (73)>0
        SetSpriteColorAlpha (73,GetSpriteColoralpha (73)-5)
    endif
    for visible = 57 to text
        if GetTextExists (visible)=1
            if GetTextColorAlpha (visible)<255
                SetTextColorAlpha (visible,GetTextColorAlpha (visible)+5)
            endif
            if GetTextColorAlpha (visible)=255 and time < 20
                time = time + 1
            endif
            if GetTextColorAlpha (visible)=255 and time = 20
                DeleteText (visible)
                time = 0
            endif

        endif
    next visible

    // Turning Rocket
    increase# = increase# + .2
    if direction = 1 and Spinning = 1
        SetSpriteAngle (1,GetSpriteAngle(1)+increase#)
        traveling = direction
        if GetSpriteAngle (1) < (GoalAngle# + increase#) and GetSpriteAngle (1) > (GoalAngle# - increase#)
            Spinning = 0
        endif
    endif
    if direction = 0 and Spinning = 1
        SetSpriteAngle (1,GetSpriteAngle(1)-increase#)
        traveling = direction
        if GetSpriteAngle (1) < (GoalAngle# + increase#) and GetSpriteAngle (1) > (GoalAngle# - increase#)
            Spinning = 0
        endif
    endif
    if Spinning = 0
        traveling = 3
    endif

    sync()
    if wait >0
        wait = wait - 1
    endif
    if wait = 0
        if GetParticlesExists (havefun)=1
            SetParticlesPosition (2,-1000,-1000)
        endif
    endif
    SetSpriteImage (1,7)

    // Shooting, Collecting, and Moving Coins

    for CoinCollecting = 2500 to coin
        if GetSpriteExists (CoinCollecting)=1
            if GetSpriteCollision (1,CoinCollecting)=1
                PlaySound (4)
                DeleteSprite (CoinCollecting)
                text = text + 1
                CreateText (text,"+500")
                SetTextPosition (text,GetSpriteX(1)+25,GetSpriteY(1)-25)
                SetTextColorAlpha (text,0)
                SetTextSize (text,20)
                score = score + 500
            endif
        endif
        if GetSpriteExists (CoinCollecting)=1
            for bullets = 201 to 209
                if GetSpriteCollision (bullets,CoinCollecting)=1
                    PlaySound (4)
                    text = text + 1
                    CreateText (text,"+500")
                    SetTextPosition (text,GetSpriteX(CoinCollecting),GetSpriteY(CoinCollecting))
                    SetTextColorAlpha (text,0)
                    SetTextSize (text,20)
                    score = score + 500
                    DeleteSprite (CoinCollecting)
                    exit
                endif
            next bullets
        endif
    next CoinCollecting
    if GetSpriteImageID(100)=5

        // Alien Spaceships

        KeepTrack = KeepTrack + 1

        If GetSpriteExists (83)=0
            StopSound (9)
        endif

        if GetSpriteExists (83)=1

        Running = Running + 1
        if Mod(Running, 30) = 0
            Ymotion = Random (1,3)-2
        endif
        For number = 1 to 9
            if AlienBullet# [number,1]=0
                SetSpritePosition (number + 230,GetSpriteX (83)+5,GetSpriteY (83)+5)
                SetSpriteColorAlpha (number + 230,0)
            endif
        next number
        if Mod(Running, 60) = 0
            for number = 1 to 9
                if AlienBullet# [number,1]=0
                    AlienBullet# [number,2] = (GetSpriteX (1)- GetSpriteX (83)) + (Random (1,100)-50)
                    AlienBullet# [number,3] = GetSpriteY (1)- GetSpriteY (83) + (Random (1,100)-50)
                    AlienBullet# [number,1] = 1
                    SetSpriteColorAlpha (number + 230,255)
                    exit
                endif
            next number
        endif
        if GetSpriteImageID (83)=83
            if Mod(Running, 3) = 0
                SetSpriteImage (83,84)
            endif
            else
            if Mod(Running, 3) = 0
                SetSpriteImage (83,83)
            endif
        endif
        if Sideways = 1
            SetSpriteX (83,GetSpriteX(83)-2)
        endif
        if Sideways = 2
            SetSpriteX (83,GetSpriteX(83)+2)
        endif
        SetSpriteY (83,GetSpriteY (83) + Ymotion)
        if GetSpriteX (83)>480 or GetSpriteX (83)<-35 or GetSpriteY (83)>320 or GetSpriteY (83)<-20
            DeleteSprite (83)
            StopSound (9)
        endif

        if GetSpriteExists (83)=1
            if GetSpriteCollision (83,1)=1 and GetSpriteColorAlpha (1)=255
                if lives = 0
                    Gosub GameOver
                endif
                if lives > 0
                    Gosub LoseALife
                endif
            endif
        endif

        for Bullets =  201 to 209
            if GetSpriteColorAlpha (Bullets)>0 and GetSpriteExists (83)=1
            if GetSpriteCollision (83,Bullets)=1
                PlaySound (10)
                text = text + 1
                CreateText (text,"+700")
                SetTextPosition (text,GetSpriteX(83),GetSpriteY(83))
                SetTextColorAlpha (text,0)
                SetTextSize (text,20)
                score = score + 700
                DeleteSprite (83)
                StopSound (9)
                exit
            endif
            endif
        next
        endif
        if GetSpriteExists (83)=0
            Running = 0
            for number = 1 to 9
                if AlienBullet# [number,1]=0
                    SetSpritePosition (number + 230, 1000,1000)
                    SetSpriteColorAlpha (number + 230,0)
                endif
            next number
        endif
        for number = 1 to 9
            if AlienBullet# [number,1]=1
                SetSpriteX (number + 230, GetSpriteX(number + 230) + (AlienBullet# [number,2] / 35))
                SetSpriteY (number + 230, GetSpriteY(number + 230) + (AlienBullet# [number,3] / 35))
            endif
            if GetSpriteCollision (number + 230,1)=1 and GetSpriteColorAlpha (1)=255
                AlienBullet# [number,1]=0
                SetSpriteColorAlpha (number + 230,0)
                if lives = 0
                    Gosub GameOver
                endif
                if lives > 0
                    Gosub LoseALife
                endif
            endif
        next number

        // Accelerating

        if GetPointerState ()=1 and GetSpriteHitTest (102,GetPointerX(),GetPointerY())=1
            if accel#<4
                accel# = accel# + .05
            endif
            t# = cos(GetSpriteAngle(1))
            g# = sin(GetSpriteAngle(1))

            SetParticlesPosition (1,GetSpriteX(1)+((t# + 1)*7),GetSpriteY(1)+((g# + 1)*7))
            SetParticlesImage (1,500)
            SetParticlesStartZone (1,0,-4,4,4)
            SetParticlesDirection (1,100*t#,100*g#)
            SetParticlesFrequency (1,250)
            SetParticlesSize (1,10)
            SetParticlesLife (1,1)
            SetParticlesAngle (1,40)

            AddParticlesColorKeyFrame (1,0,255,0,0,0)
            AddParticlesColorKeyFrame (1,.1,255,0,0,255)
            AddParticlesColorKeyFrame (1,.8,255,0,0,255)
            AddParticlesColorKeyFrame (1,1,255,0,0,0)

            SetSpriteScale (102,.47,.47)
            SetSpritePosition (102,193,273)
        endif
        if GetSpriteHitTest (102,GetPointerX(),GetPointerY())=0 or GetPointerState()=0
            SetSpriteScale (102,.5,.5)
            SetSpritePosition (102,190,270)
        endif
        SetSpriteX (1,GetSpriteX(1) - accel#*t#)
        SetSpriteY (1,GetSpriteY(1) - accel#*g#)

        if GetSpriteX (1)>504
            SetSpriteX (1,-35)
        endif
        if GetSpriteY (1)>335
            SetSpriteY (1,-35)
        endif
        if GetSpriteX (1)<-45
            SetSpriteX (1,504)
        endif
        if GetSpriteY (1)<-45
            SetSpriteY (1,335)
        endif

        if GetSpriteHitTest (102,GetPointerX(),GetPointerY())=0 or GetPointerState()=0
            if accel#>0.1
                accel# = accel# - .01
            endif
            SetParticlesPosition (1,1000,1000)
        endif

        // Turning Rocket and Shooting

        if GetPointerPressed()=1 and GetSpriteHitTest (100,GetPointerX(),GetPointerY())=0 and GetSpriteHitTest (102,GetPointerX(),GetPointerY())=0
			PlaySound (1)

            if GetPointerX ()>x2# or GetPointerX () < x2#

            x2# = GetPointerX()
            y2# = GetPointerY()

            x3# = GetSpriteX(1)
            y3# = GetSpriteY(1)

            if x2#<x3# and y2#<y3#
                bottomleg# = (x3# - x2#)
                sideleg# = (y3# - y2#)

                GoalAngle# = Atan(sideleg#/bottomleg#)
            endif
            if x2#>x3# and y2#<y3#
                bottomleg# = (x2# - x3#)
                sideleg# = (y3# - y2#)

                angle# = Atan(sideleg#/bottomleg#)

                GoalAngle# = (90-angle#)+90
            endif
            if x2#<x3# and y2#>y3#
                bottomleg# = (x3# - x2#)
                sideleg# = (y2# - y3#)

                angle# = Atan(sideleg#/bottomleg#)

                GoalAngle# = (90-angle#)+270
            endif
            if x2#>x3# and y2#>y3#
                bottomleg# = (x2# - x3#)
                sideleg# = (y2# - y3#)

                angle# = Atan(sideleg#/bottomleg#)

                GoalAngle# = (angle#)+180
            endif

            if GoalAngle# < GetSpriteAngle (1)
                CompareAngle1 = (360-GetSpriteAngle(1))+GoalAngle#
            endif
            if GoalAngle# > GetSpriteAngle (1)
                CompareAngle1 = (GoalAngle# - GetSpriteAngle(1))
            endif
            CompareAngle2 = 360 - CompareAngle1

            if CompareAngle1 < CompareAngle2
                direction = 1
            endif
            if CompareAngle1 > CompareAngle2
                direction = 0
            endif
            if direction = traveling + 1 or direction = traveling - 1 or traveling = 3
                increase# = 0
            endif
            Spinning = 1
            endif
            for number = 1 to 9
                if Bullet# [number,1]=0
                    Bullet# [number,2] = cos(GetSpriteAngle(1))
                    Bullet# [number,3] = sin(GetSpriteAngle(1))
                    Bullet# [number,1] = 1
                    SetSpriteAngle (number+200,GetSpriteAngle (1))
                    exit
                endif
            next number
        endif
        // Position Asteroids

        for number = 2 to asteroid
            if GetSpriteExists (number)=1
            x# = cos(GetSpriteAngle(number))
            y# = sin(GetSpriteAngle(number))

            if GetSpriteImageId (number)=2
                SetSpritePosition(number,GetSpriteX(number)-.5*x#,GetSpriteY(number)-1*y#)
            endif
            if GetSpriteImageId (number)=3
                SetSpritePosition(number,GetSpriteX(number)-1*x#,GetSpriteY(number)-1.5*y#)
            endif
            if GetSpriteImageId (number)=8
                SetSpritePosition(number,GetSpriteX(number)-2*x#,GetSpriteY(number)-2*y#)
            endif

            if GetSpriteX(number)>480
                SetSpriteX(number,-40)
            endif
            if GetSpriteX(number)<-40
                SetSpriteX(number,480)
            endif
            If GetSpriteY(number)>320
                SetSpriteY(number,-40)
            endif
            If GetSpriteY(number)<-40
                SetSpriteY(number,320)
            endif
            endif
        next number
    endif

    // Shooting Asteroids

    For abc = 2 to asteroid
        for jump = 201 to 209
            If GetSpriteExists (abc)=1
            If GetSpriteCollision (jump,abc)=1 and GetSpriteColorAlpha (jump)=255
                PlaySound (2)

                thisx = GetSpriteX (abc)
                thisy = GetSpriteY (abc)

                hi = asteroid + 1

                image = GetSpriteImageId (abc)

                if image = 8
                    CreateSprite (coin,18)
                    SetSpritePosition (coin,GetSpriteX(abc),GetSpriteY(abc))
                    SetSpriteScale (coin,.07,.07)
                    SetSpritePhysicsOn (Coin,2)
                    SetPhysicsGravity (0,100)
                    SetPhysicsWallBottom (0)

                    coin = coin + 1
                    wait = 30

                    SetParticlesPosition (havefun,GetSpriteX(abc)+10,GetSpriteY(abc)+10)
                    SetParticlesImage (2,501)
                    SetParticlesLife (2,.5)
                    SetParticlesFrequency (2,40)
                    SetParticlesSize (2,10)
                    SetParticlesDirection ( 2, 20, 20 )
                    SetParticlesAngle ( 2, 360 )
                endif
                DeleteSprite (abc)

                if image = 2
                    CreateSprite (abc,3)
                    CreateSprite (hi,3)
                    asteroid = asteroid + 1
                    SetSpriteScale (abc,.6,.6)
                    SetSpriteScale (hi,.6,.6)
                endif
                if image = 3
                    CreateSprite (abc,8)
                    CreateSprite (hi,8)
                    asteroid = asteroid + 1
                    SetSpriteScale (abc,.4,.4)
                    SetSpriteScale (hi,.4,.4)
                endif

                if image <4
                    SetSpritePosition (abc,thisx + 5,thisy + 5)
                    SetSpritePosition (hi,thisx - 5,thisy - 5)

                    SetSpriteAngle (abc,random (0,360))
                    SetSpriteAngle (hi,random (0,360))

                    SetSpriteShape (abc,3)
                    SetSpriteShape (hi,3)
                endif

                scores = scores + 100
                score = score + 100
                Bullet# [jump-200,1]=0
                SetSpritePosition (jump,1000,1000)
            endif
            endif
        next jump
    next abc

    // Game Over

    for g = 2 to asteroid
        If GetSpriteExists (g)=1
        if GetSpriteCollision (g,1)=1 and lives = 0 and GetSpriteColorAlpha (1)=255

            Gosub GameOver

            GameOver:

            LoadImage (93,"New.png")

            StopSound (9)

            if GetTextExists (74)
                DeleteText (74)
            endif

            OpenToRead (1,"HighScore1.txt")
            HighScore = ReadInteger (1)
            CloseFile (1)

            if HighScore < score
                OpenToWrite (1,"HighScore1.txt",0)
                WriteInteger (1,score)
                CloseFile (1)
                HighScore = score
            endif

            x# = GetSpriteX (1)
            y# = GetSpriteY (1)

            PlaySound (3)

            DeleteSprite (1)
            DeleteSprite (100)
            DeleteSprite (102)
            DeleteText (2)
            for this = 201 to 209
                DeleteSprite (this)
            next this

            CreateSprite (2000,11)
            CreateSprite (2001,12)
            CreateSprite (2002,13)
            CreateSprite (2003,14)
            CreateSprite (2005,2004)

            SetSpritePosition (2000,x# + 1,y#)
            SetSpritePosition (2001,x#,y#+1)
            SetSpritePosition (2002,x#-1,y#-1)
            SetSpritePosition (2003,30,270)
            SetSpritePosition (2005,310,275)

            SetSpriteAngle (2000,120)
            SetSpriteAngle (2001,30)
            SetSpriteAngle (2002,237)

            SetSpriteScale (2000,.2,.2)
            SetSpriteScale (2001,.2,.2)
            SetSpriteScale (2002,.2,.2)
            SetSpriteScale (2003,.85,.85)

            SetSpriteColorAlpha (2003,0)
            SetSpriteColorAlpha (2005,0)

            C1 = cos (GetSpriteAngle (2000))
            S1 = sin (GetSpriteAngle (2000))
            C2 = cos (GetSpriteAngle (2001))
            S2 = sin (GetSpriteAngle (2001))
            C3 = cos (GetSpriteAngle (2002))
            S3 = sin (GetSpriteAngle (2002))

            CreateText (1000,"Game Over")
            CreateText (1001,"Your Score: " + str (score))
            CreateText (1002,"High Score: " + str (HighScore))

            SetTextPosition (1000,140,0)
            SetTextPosition (1001,240,80)
            SetTextPosition (1002,240,130)
            SetTextAlignment (1001,1)
            SetTextAlignment (1002,1)
            SetTextSize (1000,40)
            SetTextSize (1001,40)
            SetTextSize (1002,40)
            SetTextColor (1000,72,254,68,255)
            SetTextColor (1001,72,254,68,0)
            SetTextColor (1002,72,254,68,0)

            if score = HighScore
                CreateSprite (2004,93)
                SetSpriteAngle (2004,330)
                SetSpriteScale (2004,.6,.6)
                SetSpritePosition (2004,10,125)
                SetSpriteColorAlpha (2004,0)
            endif

            level = 1
            video = 0

            do
                video = video + 1
                sync()

                SetSpritePosition (2000,GetSpriteX(2000)-(.3 *C1),GetSpriteY(2000)-(.3*S1))
                SetSpritePosition (2001,GetSpriteX(2001)-(.3*C2),GetSpriteY(2001)-(.3*S2))
                SetSpritePosition (2002,GetSpriteX(2002)-(.3*C3),GetSpriteY(2002)-(.3*S3))

                if GetSpriteColorAlpha (2000)>0
                    SetSpriteColorAlpha (2000,GetSpriteColorAlpha (2000)-3)
                    SetSpriteColorAlpha (2001,GetSpriteColorAlpha (2001)-3)
                    SetSpriteColorAlpha (2002,GetSpriteColorAlpha (2002)-3)
                endif
                if GetSpriteColorAlpha (2003)<255
                    SetSpriteColorAlpha (2003,GetSpriteColorAlpha(2003)+2)
                    SetSpriteColorAlpha (2005,GetSpriteColorAlpha(2005)+2)
                endif
                if video = 100
                    SetTextColorAlpha (1001,255)
                    PlaySound (18)
                endif
                if video = 150
                    SetTextColorAlpha (1002,255)
					PlaySound (18)
                endif
                if video = 170 and GetSpriteExists (2004)=1
                    SetSpriteColorAlpha (2004,255)
					PlaySound (19)
                endif

                DeleteParticles (1)
                DeleteParticles (2)

                if GetPointerPressed ()=1
                    if GetSpriteHitTest (2003,GetPointerX(),GetPointerY())=1 and GetSpriteColorAlpha (2003)=>255
                        SetSpriteScale (2003,.8,.8)
                        while b<10
                            sync ()
                            b = b + 1
                        endwhile
                        score = 1000
                        lives = 3
                        gosub Replay
                    endif
                    if GetSpriteHitTest (2005,GetPointerX(),GetPointerY())=1 and GetSpriteColorAlpha (2005)=>255
                        end
                    endif
                endif
            loop
        endif

        //Losing a Life

        if GetSpriteCollision (g,1)=1 and lives > 0 and GetSpriteColorAlpha (1)=255

            Gosub LoseALife

            LoseALife:

            numbertokeeptrack = 1

            for g = 57 to text
                If GetTextExists (g)=1
                    DeleteText (g)
                endif
            next g

            if GetTextExists (74)
                DeleteText (74)
            endif

            x# = GetSpriteX (1)
            y# = GetSpriteY (1)

			PlaySound (3)

            DeleteSprite (1)

            CreateSprite (2000,11)
            CreateSprite (2001,12)
            CreateSprite (2002,13)

            SetSpritePosition (2000,x# + 1,y#)
            SetSpritePosition (2001,x#,y#+1)
            SetSpritePosition (2002,x#-1,y#-1)

            SetSpriteAngle (2000,120)
            SetSpriteAngle (2001,30)
            SetSpriteAngle (2002,237)

            SetSpriteScale (2000,.2,.2)
            SetSpriteScale (2001,.2,.2)
            SetSpriteScale (2002,.2,.2)

            C1 = cos (GetSpriteAngle (2000))
            S1 = sin (GetSpriteAngle (2000))
            C2 = cos (GetSpriteAngle (2001))
            S2 = sin (GetSpriteAngle (2001))
            C3 = cos (GetSpriteAngle (2002))
            S3 = sin (GetSpriteAngle (2002))

            DeleteParticles (1)
            DeleteParticles (2)
            DeleteParticles (3)

            lives = lives - 1

            do
                SetSpritePosition (2000,GetSpriteX(2000)-(.3 *C1),GetSpriteY(2000)-(.3*S1))
                SetSpritePosition (2001,GetSpriteX(2001)-(.3*C2),GetSpriteY(2001)-(.3*S2))
                SetSpritePosition (2002,GetSpriteX(2002)-(.3*C3),GetSpriteY(2002)-(.3*S3))

                if GetSpriteColorAlpha (2000)>0
                    SetSpriteColorAlpha (2000,GetSpriteColorAlpha (2000)-3)
                    SetSpriteColorAlpha (2001,GetSpriteColorAlpha (2001)-3)
                    SetSpriteColorAlpha (2002,GetSpriteColorAlpha (2002)-3)
                endif

                sync ()

                smallwait = smallwait + 1

                if smallwait = 100
                    DeleteSprite (2000)
                    DeleteSprite (2001)
                    DeleteSprite (2002)
                    Gosub Continuing
                endif
                for number = 2 to asteroid
                    if GetSpriteExists (number)=1
                    x# = cos(GetSpriteAngle(number))
                    y# = sin(GetSpriteAngle(number))

                    if GetSpriteImageId (number)=2
                        SetSpritePosition(number,GetSpriteX(number)-.5*x#,GetSpriteY(number)-1*y#)
                    endif
                    if GetSpriteImageId (number)=3
                        SetSpritePosition(number,GetSpriteX(number)-1*x#,GetSpriteY(number)-1.5*y#)
                    endif
                    if GetSpriteImageId (number)=8
                        SetSpritePosition(number,GetSpriteX(number)-2*x#,GetSpriteY(number)-2*y#)
                    endif

                    if GetSpriteX(number)>480
                        SetSpriteX(number,-40)
                    endif
                    if GetSpriteX(number)<-40
                        SetSpriteX(number,480)
                    endif
                    If GetSpriteY(number)>320
                        SetSpriteY(number,-40)
                    endif
                    If GetSpriteY(number)<-40
                        SetSpriteY(number,320)
                    endif
                    endif
                next number
                for z = 201 to 209
                    if Bullet# [z-200,1]=1
                        SetSpritePosition (z,GetSpriteX(z)-5*Bullet#[z-200,2],GetSpriteY(z)-5*Bullet#[z-200,3])
                        SetSpriteColorAlpha (z,255)
                        Bullet# [z-200,4]= Bullet# [z-200,4] + 1
                    endif
                    if GetSpriteX (z)>480 or GetSpriteX (z)<0 or GetSpriteY (z)>320 or GetSpriteY (z)<0
                        Bullet# [z-200,1]=0
                    endif
                next z

                if GetSpriteExists (83)=1

                Running = Running + 1
                if mod(Running, 30) = 0
                    Ymotion = Random (1,3)-2
                endif

                For number = 1 to 9
                    if AlienBullet# [number,1]=0
                        SetSpritePosition (number + 230,GetSpriteX (83)+5,GetSpriteY (83)+5)
                        SetSpriteColorAlpha (number + 230,0)
                    endif
                next number

                if GetSpriteImageID (83)=83
                    if mod(Running, 3) = 0
                        SetSpriteImage (83,84)
                    endif
                else
                    if mod(Running, 3) = 0
                        SetSpriteImage (83,83)
                    endif
                endif

                if Sideways = 1
                    SetSpriteX (83,GetSpriteX(83)-2)
                endif
                if Sideways = 2
                    SetSpriteX (83,GetSpriteX(83)+2)
                endif
                SetSpriteY (83,GetSpriteY (83) + Ymotion)
                if GetSpriteX (83)>480 or GetSpriteX (83)<-35 or GetSpriteY (83)>320 or GetSpriteY (83)<-20
                    DeleteSprite (83)
                    StopSound (9)
                endif

                endif
                if GetSpriteExists (83)=0
                    Running = 0
                    for number = 1 to 9
                        if AlienBullet# [number,1]=0
                            SetSpritePosition (number + 230, 1000,1000)
                            SetSpriteColorAlpha (number + 230,0)
                        endif
                    next number
                endif
                for number = 1 to 9
                    if AlienBullet# [number,1]=1
                        SetSpriteX (number + 230, GetSpriteX(number + 230) + (AlienBullet# [number,2] / 35))
                        SetSpriteY (number + 230, GetSpriteY(number + 230) + (AlienBullet# [number,3] / 35))
                    endif
                next number
            loop

        endif
        endif

        // Next Level

        if scores = 700*(asteroids-1)

            StopSound (9)

            If GetTextExists (74)=1
                DeleteText (74)
            endif

            level = level + 1
            v = 300
            alpha1 = 0
            countit = 0
            Bonus = level*1000 - 1000
            CreateText (319,"Cleared!")
            CreateText (320,"Level Bonus: " + str (Bonus))
            SetTextSize (320,30)
            SetTextSize (319,30)
            SetTextAlignment (319,1)
            SetTextAlignment (320,1)
            SetTextPosition (319,240,30)
            SetTextPosition (320,240,100)
            SetTextColor (319,72,254,68,255)
            SetTextColor (320,72,254,68,255)

            CreateSprite (321,64)
            SetSpritePosition (321,70,250)
            SetSpriteColorAlpha (321,0)

            DeleteSprite (102)

			PlaySound (6)
            do
                v = v - 1
                alpha = alpha + 2
                if increase = 0 and countit <3
                    alpha1 = alpha1 + 20
                endif
                if increase = 1 and countit <3
                    alpha1 = alpha1 - 20
                endif
                if alpha < 255
                    SetTextColorAlpha (319,alpha)
                endif
                if showup =1
                    SetTextColorAlpha (320,alpha1)
                endif
                deleteparticles (2)

                if alpha = 120
                    SetSpriteColorAlpha (321,255)
                endif

                if alpha1 >= 255
                    increase = 1
                    countit = countit + 1
                    if countit <4
						PlaySound (5)
                    endif
                endif
                if alpha1 <= 0
                    increase = 0
                    showup = 1
                endif
                sync ()
                if GetPointerPressed()=1 and GetSpriteHitTest (321,GetPointerX(),GetPointerY())=1 and GetSpriteColorAlpha (321)=255
                    PlaySound (20)
                    exit
                endif
            loop

            gosub Replay
        endif

    next g

    // Shooting Bullets

    if GetSpriteImageID(100)=5
        if GetPointerPressed()=1 and GetPointerX()>240 and GetPointerY()<160
		PlaySound (1)
        for number = 1 to 9
            if Bullet# [number,1]=0
                Bullet# [number,2] = cos(GetSpriteAngle(1))
                Bullet# [number,3] = sin(GetSpriteAngle(1))
                Bullet# [number,1] = 1
                SetSpriteAngle (number+200,GetSpriteAngle (1))
                exit
            endif
        next number
        endif
    endif

    Play_Pause ()
    PositionBullets ()
    if GetSpriteImageID (100)=5
        if GetSpriteColorAlpha (101)>0
            SetSpriteColorAlpha (101,GetSpriteColorAlpha(101)-5)
            SetSpriteColorAlpha (157,GetSpriteColorAlpha(157)-5)
        endif
        if GetSpriteColorAlpha (158)>0
            SetSpriteColorAlpha (158,GetSpriteColorAlpha(158)-5)
        endif
    endif
    If GetSpriteImageID (100)=6
        if GetSpriteColorAlpha (101)<255
            SetSpriteColorAlpha (101,GetSpriteColorAlpha(101)+5)
            SetSpriteColorAlpha (157,GetSpriteColorAlpha(157)+5)
            SetSpriteColorAlpha (158,GetSpriteColorAlpha(158)+5)
        endif
    endif
loop

function Play_Pause ()
    If GetPointerPressed()=1 and GetSpriteHitTest(100,GetPointerX(),GetPointerY())=1
        if GetSpriteImageID (100)=6
            SetSpriteImage (100,5)
            SetSpriteScale (100,.5,.5)
            if GetSpriteExists (83)=1
                playsound (9,100,1)
            endif
            x = 1
        endif
        If GetSpriteImageID (100)=5 and x = 0
            SetSpriteImage (100,6)
            SetSpriteScale (100,.5,.5)
            StopSound (9)
        endif
    endif
    If GetPointerPressed()=1
        if GetSpriteHitTest(158,GetPointerX(),GetPointerY())=1 and GetSpriteImageID (100)=6
            SetSpriteImage (100,5)
            SetSpriteScale (100,.5,.5)
            SetSpriteColorAlpha (158,0)
            if GetSpriteExists (83)=1
                playsound (9,100,1)
            endif
			PlaySound (6)
        endif
        if GetSpriteHitTest(157,GetPointerX(),GetPointerY())=1 and GetSpriteImageID (100)=6
            end
        endif
    endif
endfunction

function PositionBullets ()
    for z = 201 to 209
        if Bullet# [z-200,1]=0
            SetSpritePosition (z,GetSpriteX(1)+8,GetSpriteY(1)+5)
            SetSpriteColorAlpha (z,0)
            Bullet# [z-200,4]=0
        endif
        if Bullet# [z-200,1]=1
            SetSpritePosition (z,GetSpriteX(z)-5*Bullet#[z-200,2],GetSpriteY(z)-5*Bullet#[z-200,3])
            SetSpriteColorAlpha (z,255)
            Bullet# [z-200,4]= Bullet# [z-200,4] + 1
        endif
        if GetSpriteX (z)>480 or GetSpriteX (z)<0 or GetSpriteY (z)>320 or GetSpriteY (z)<0
            Bullet# [z-200,1]=0
        endif
    next z
endfunction

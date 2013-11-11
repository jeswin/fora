#Users
tributeToAaron = {
    username: 'aaronsw', 
    name: 'Aaron Swartz Tribute', 
    location: 'Brooklyn, NYC',
    credentials_type: 'builtin',
    credentials_username: 'aaronsw',
    credentials_password: 'liks345F',
    email: 'me@aaronsw.com',
    picture: '/images/site/user.jpg',
    thumbnail: '/images/site/user.jpg',
    about: 'Aaron Hillel Swartz was an American computer programmer, writer, political organizer and Internet activist. Swartz was involved in the development of RSS, Creative Commons, web.py and Reddit.'
}

jeswin = {
    username: 'jeswin', 
    name: 'Jeswin', 
    location: 'Bangalore, India',
    credentials_type: 'twitter',
    credentials_id: '15833712',
    credentials_username: 'jeswin',
    credentials_accessToken: 'invalid_token',
    credentials_accessTokenSecret: 'invalid_token_secret',
    email: 'jeswinpk@agilehead.com',
    picture: 'https://dge9rmgqjs8m1.cloudfront.net/global/6de4c55ef2bc00dfc5c521507ef2a42e6510b7a50114395442e00553d379b851cff71cf95e2bf3cb6a3b3bc3fbdb504c12c4d71779b248f5409e350ddf47eb54f9f7f8d7d4b1eafe8a95cd7825b9c9da/avatar.96.gif?r=3',
    thumbnail: 'https://dge9rmgqjs8m1.cloudfront.net/global/6de4c55ef2bc00dfc5c521507ef2a42e6510b7a50114395442e00553d379b851cff71cf95e2bf3cb6a3b3bc3fbdb504c12c4d71779b248f5409e350ddf47eb54f9f7f8d7d4b1eafe8a95cd7825b9c9da/avatar.40.gif?r=3',
    about: 'Founder of Poetry(poe3.com). Proud sponsor of the RedBull F1 team by way of drinking too many cans.'
}

ebin = {
    username: 'ebin', 
    name: 'Ebin John', 
    location: 'Bangalore, India',
    credentials_type: 'builtin',
    credentials_username: 'ebin'
    credentials_password: 'liks345F'
    email: 'ebin.john@outlook.com',
    picture: 'https://lh4.googleusercontent.com/-SyoIfkRItqE/AAAAAAAAAAI/AAAAAAAAAw0/nxHk4Nqrpm8/s120-c/photo.jpg',
    thumbnail: 'https://lh4.googleusercontent.com/-SyoIfkRItqE/AAAAAAAAAAI/AAAAAAAAAw0/nxHk4Nqrpm8/s120-c/photo.jpg'
}

anupk7 = {
    username: 'anupk7', 
    name: 'Anup Kesavan', 
    location: 'Bangalore, India',
    credentials_type: 'builtin',
    credentials_username: 'anupk7'
    credentials_password: 'liks345F'
    email: 'anupk7@gmail.com',
    picture: 'http://m.c.lnkd.licdn.com/mpr/pub/image-JLwJ9fTJBTv3Ur9xL18X4Ph00ExD3ZziHjwE4tuK0R2-tCRVJLwEuu6J0rLm3Zhhd9sr/anup-kesavan-ponnarassery.jpg',
    thumbnail: 'http://m.c.lnkd.licdn.com/mpr/pub/image-JLwJ9fTJBTv3Ur9xL18X4Ph00ExD3ZziHjwE4tuK0R2-tCRVJLwEuu6J0rLm3Zhhd9sr/anup-kesavan-ponnarassery.jpg',
}

users = [tributeToAaron, jeswin, ebin, anupk7]

#Forums
poetry = {
    name: 'Poetry',
    description: 'Selected Poetry from around the world.',
    cover_src: 'https://twimg0-a.akamaihd.net/profile_images/2926658252/11c12e7e2f293194c95c6a5ba3f4d707.jpeg',
    cover_small: 'https://twimg0-a.akamaihd.net/profile_images/2926658252/11c12e7e2f293194c95c6a5ba3f4d707.jpeg',    
    permission: 'public',
    type: 'public',
    category: 'literature',
    _createdBy: 'jeswin'  
}

movies = {
    name: 'Modern Cinema',
    description: 'Movies that won\'t make any sense. Not now, not ever.',
    cover_src: 'http://fc01.deviantart.net/fs71/i/2012/224/8/6/charlie_chaplin_02__conceptual_fashion__by_lastwishes-d5au8rm.jpg',
    cover_small: 'http://fc01.deviantart.net/fs71/i/2012/224/8/6/charlie_chaplin_02__conceptual_fashion__by_lastwishes-d5au8rm.jpg',
    permission: 'public',    
    type: 'public',
    category: 'movies',
    _createdBy: 'jeswin'       
}

rawNerve = {
    name: 'Raw Nerve',
    description: 'This is a series of pieces on getting better at life.',
    cover_src: 'http://blogs-images.forbes.com/singularity/files/2013/01/Aaron_Swartz.jpg',
    cover_small: 'http://blogs-images.forbes.com/singularity/files/2013/01/Aaron_Swartz.jpg',
    permission: 'public',
    type: 'public',
    category: 'life',
    _about: 'about-raw-nerve.md',
    _message: 'message-raw-nerve.md',
    _createdBy: 'aaronsw'   
}

itsMyLife = {
    name: 'It\'s my life',
    description: 'Everyday life from corners of the world.',
    cover_src: 'https://twimg0-a.akamaihd.net/profile_images/2371312033/image.jpg',
    cover_small: 'https://twimg0-a.akamaihd.net/profile_images/2371312033/image.jpg',
    permission: 'public',
    type: 'public',
    category: 'life',
    _createdBy: 'jeswin'   
}

makingStuff =  {
    name: 'Making Stuff',
    description: 'Everybody can make stuff. This is about stuff you\'ve made.',
    cover_src: 'http://cdnimg.visualizeus.com/thumbs/aa/06/colors,colours,costume,derro,fancy,dress,festival-aa06d899eec02dec6f84cb017ea3bf80_h.jpg',
    cover_small: 'http://cdnimg.visualizeus.com/thumbs/aa/06/colors,colours,costume,derro,fancy,dress,festival-aa06d899eec02dec6f84cb017ea3bf80_h.jpg',
    permission: 'public',
    type: 'public',
    category: 'life',
    _createdBy: 'jeswin'   
}

travel = {
    name: 'Travel',
    description: 'Let\'s go.',
    cover_src: 'http://farm4.staticflickr.com/3016/3008866354_7481cc3f70_z.jpg',
    cover_small: 'http://farm4.staticflickr.com/3016/3008866354_7481cc3f70_z.jpg',
    permission: 'public',
    type: 'public',
    category: 'travel',
    _createdBy: 'jeswin'   
}

computers = {
    name: 'Computers',
    description: 'Garbage in. Garbage out.',
    cover_src: 'http://cdn-static.zdnet.com/i/r/story/70/00/016684/apple-wwdc-mac-pro-0596610x488-610x488.jpg?hash=MTZjLGH0AT&upscale=1',
    cover_small: 'http://cdn-static.zdnet.com/i/r/story/70/00/016684/apple-wwdc-mac-pro-0596610x488-610x488.jpg?hash=MTZjLGH0AT&upscale=1',
    permission: 'public',
    type: 'public',
    category: 'technology',
    _createdBy: 'jeswin'   
}

theGreatMasters = {
    name: 'Great Masters',
    description: 'Paintings from the great masters.',
    cover_src: 'http://www.claude-monet.com/images/paintings/impression-sunrise.jpg',
    cover_small: 'http://www.claude-monet.com/images/paintings/impression-sunrise.jpg',
    permission: 'public',
    type: 'public',
    category: 'art',
    _createdBy: 'jeswin'   
}

streetFood = {
    name: 'Street Food',
    description: 'Dai Pai Dong to Vada Pav. The love of street food.',
    cover_src: 'http://shecookshecleans.files.wordpress.com/2011/07/korean-chic-skewers.jpg?w=500',
    cover_small: 'http://shecookshecleans.files.wordpress.com/2011/07/korean-chic-skewers.jpg?w=500',
    permission: 'public',
    type: 'public',
    category: 'food-and-drinks'
    _createdBy: 'jeswin'   
}

guzzlers = {
    name: 'Guzzlers',
    description: 'Calling Beer guzzlers. We are already a few pitchers down.',
    cover_src: 'http://media.tumblr.com/tumblr_mdlnc6eBsm1qd0jy3.jpg',
    cover_small: 'http://media.tumblr.com/tumblr_mdlnc6eBsm1qd0jy3.jpg',
    permission: 'public',
    type: 'public',
    category: 'food-and-drinks'
    _createdBy: 'jeswin'   
}

earlyMornings = {
    name: 'Early Mornings',
    description: 'Waking up early. Catching the day in its best act.',
    cover_src: 'http://www.minigallery.co.uk/Erica_Kirkpatrick/images/20120426093259079_l/large/Misty_Pond_Landscape_42.jpg',
    cover_small: 'http://www.minigallery.co.uk/Erica_Kirkpatrick/images/20120426093259079_l/large/Misty_Pond_Landscape_42.jpg',
    permission: 'public',
    type: 'public',
    category: 'life',
    _createdBy: 'jeswin'  
}

forums = [poetry, movies, rawNerve, itsMyLife, makingStuff, travel, computers, theGreatMasters, streetFood, guzzlers, earlyMornings]

#Articles
believeYouCanChange = {
    title: 'Believe you can change',
    type: "Article",
    _content: 'believe-you-can-change.md',
    cover_src: 'http://3.bp.blogspot.com/-v3u0buEsK5E/T7XVL4nuUtI/AAAAAAAACu8/2Hte6GPRJ_M/s1600/dolphin.png',
    cover_small: 'http://3.bp.blogspot.com/-v3u0buEsK5E/T7XVL4nuUtI/AAAAAAAACu8/2Hte6GPRJ_M/s1600/dolphin.png',
    _forum: 'raw-nerve',
    _createdBy: 'aaronsw',
    _meta: 'featured'
}

cherishMistakes = {
    title: 'Cherish Mistakes',
    type: "Article",
    _content: 'cherish-mistakes.md',
    cover_src: 'http://img2.etsystatic.com/008/0/5851351/il_fullxfull.370263870_r8lg.jpg',
    cover_small: 'http://img2.etsystatic.com/008/0/5851351/il_fullxfull.370263870_r8lg.jpg',
    _forum: 'raw-nerve',
    _createdBy: 'aaronsw',
    _meta: 'featured'
}

confrontReality = {
    title: 'Confront Reality',
    type: "Article",
    _content: 'confront-reality.md',
    cover_src: 'http://www.cariboobrewing.com/wp-content/uploads/back-to-the-future-lloyd-michael-j-fox.jpeg',
    cover_small: 'http://www.cariboobrewing.com/wp-content/uploads/back-to-the-future-lloyd-michael-j-fox.jpeg',
    _forum: 'raw-nerve',
    _createdBy: 'aaronsw',
    _meta: 'featured'
}

darkKnight = {
    title: 'Dark Knight',
    type: "Article",
    _content: 'dark-knight.md',
    cover_src: 'http://www.geeksofdoom.com/GoD/img/2008/09/2008-09-11-dark_knight.jpg',
    cover_small: 'http://www.geeksofdoom.com/GoD/img/2008/09/2008-09-11-dark_knight.jpg',
    _forum: 'raw-nerve',
    _createdBy: 'aaronsw',
    _meta: 'featured'
}

fixTheMachine = {
    title: 'Lean into the pain',
    type: "Article",
    _content: 'lean-into-the-pain.md',
    cover_src: 'http://farm4.staticflickr.com/3808/9311339474_ec6db28a45_c.jpg',
    cover_small: 'http://farm4.staticflickr.com/3808/9311339474_ec6db28a45_c.jpg',
    _forum: 'raw-nerve',
    _createdBy: 'aaronsw',
    _meta: 'featured'
}

leanIntoThePain = {
    title: 'Fix the machine not the person',
    type: "Article",
    _content: 'fix-the-machine-not-the-person.md',
    cover_src: 'http://25.media.tumblr.com/tumblr_mdcyr848za1qgfiato1_1280.jpg',
    cover_small: 'http://25.media.tumblr.com/tumblr_mdcyr848za1qgfiato1_1280.jpg',
    _forum: 'raw-nerve',
    _createdBy: 'aaronsw',
    _meta: 'featured'
}

lookAtYourselfObjectively = {
    title: 'Look at yourself objectively',
    type: "Article",
    _content: 'look-at-yourself-objectively.md',
    _forum: 'raw-nerve',
    _createdBy: 'aaronsw',
    _meta: 'featured'
}

optimalBiases = {
    title: 'Optimal biases',
    type: "Article",
    _content: 'optimal-biases.md',
    cover_src: 'http://farm8.staticflickr.com/7330/9290232985_be2a915d39_c.jpg',
    cover_small: 'http://farm8.staticflickr.com/7330/9290232985_be2a915d39_c.jpg',
    _forum: 'raw-nerve',
    _createdBy: 'aaronsw',
    _meta: 'pick'
}

takeAStepBack = {
    title: 'Take a step back',
    type: "Article",
    _content: 'take-a-step-back.md',
    cover_src: 'http://thelittlecorporal.files.wordpress.com/2012/02/great_dictator.jpg',
    cover_small: 'http://thelittlecorporal.files.wordpress.com/2012/02/great_dictator.jpg',
    _forum: 'raw-nerve',
    _createdBy: 'aaronsw',
    _meta: 'featured'
}

flightOfTheIcarus = {
    title: 'Flight of the Icarus',
    type: "Article",
    _content: 'flight-of-the-icarus.md',
    cover_src: 'https://upload.wikimedia.org/wikipedia/commons/4/4c/Bol%2C_Hans_-_Landscape_with_the_Fall_of_Icarus.jpg',
    cover_small: 'https://upload.wikimedia.org/wikipedia/commons/4/4c/Bol%2C_Hans_-_Landscape_with_the_Fall_of_Icarus.jpg',
    _forum: 'raw-nerve',
    _createdBy: 'jeswin',
    _meta: 'featured'
}

huckleberryFinn = {
    title: 'Huckleberry Finn',
    type: "Article",
    _content: 'huckleberry-finn.md',
    _forum: 'raw-nerve',
    _createdBy: 'jeswin',
    _meta: 'featured'
}

articles = [believeYouCanChange, cherishMistakes, confrontReality, darkKnight, fixTheMachine, leanIntoThePain, lookAtYourselfObjectively, optimalBiases, takeAStepBack, flightOfTheIcarus, huckleberryFinn]

exports.users = users
exports.forums = forums
exports.articles = articles

import 'package:auxilium/post_format.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final usersRef = FirebaseFirestore.instance.collection('Posts');

var posts = [
  const Post(
    dp: 'https://media.istockphoto.com/vectors/avatar-vector-icon-simple-element-illustrationavatar-vector-icon-vector-id1208175274?k=20&m=1208175274&s=612x612&w=0&h=Ud2p5iidw5UDWGrzyuSiQ8eO08qzoqv_BAxnwx9qf1A=',
    username: 'Maria',
    timeAgo: '5m',
    text: 'Free English tuition! Teaching P3-P6.',
    title: 'Primary School Tuition',
    comments: '243',
  ),
  const Post(
    dp: 'https://media.istockphoto.com/vectors/avatar-vector-icon-simple-element-illustrationavatar-vector-icon-vector-id1208175274?k=20&m=1208175274&s=612x612&w=0&h=Ud2p5iidw5UDWGrzyuSiQ8eO08qzoqv_BAxnwx9qf1A=',
    username: 'Jameson',
    timeAgo: '12m',
    text: 'Thank you for meeting my request yesterday!',
    title: 'Grateful',
    comments: '46',
  ),
  const Post(
    dp: 'https://media.istockphoto.com/vectors/avatar-vector-icon-simple-element-illustrationavatar-vector-icon-vector-id1208175274?k=20&m=1208175274&s=612x612&w=0&h=Ud2p5iidw5UDWGrzyuSiQ8eO08qzoqv_BAxnwx9qf1A=',
    username: 'Andrea',
    timeAgo: '20m',
    text:
        'Leftover chicken pie from yesterday\'s dinner, fully untouched and really good! Come by, all invited.',
    title: 'Chicken Pie',
    comments: '305',
  ),
  const Post(
    dp: 'https://media.istockphoto.com/vectors/avatar-vector-icon-simple-element-illustrationavatar-vector-icon-vector-id1208175274?k=20&m=1208175274&s=612x612&w=0&h=Ud2p5iidw5UDWGrzyuSiQ8eO08qzoqv_BAxnwx9qf1A=',
    username: 'Linda',
    timeAgo: '21m',
    text:
        'Need babysitter to help with taking care of 5 y.o. as I go to work tomorrow',
    title: 'Babysitter',
    comments: '1K',
  ),
  const Post(
    dp: 'https://media.istockphoto.com/vectors/avatar-vector-icon-simple-element-illustrationavatar-vector-icon-vector-id1208175274?k=20&m=1208175274&s=612x612&w=0&h=Ud2p5iidw5UDWGrzyuSiQ8eO08qzoqv_BAxnwx9qf1A=',
    username: 'Marcus',
    timeAgo: '26m',
    text: 'Looking for workspace to study for my PSLE',
    title: 'Study Space',
    comments: '10K',
  ),
  const Post(
    dp: 'https://media.istockphoto.com/vectors/avatar-vector-icon-simple-element-illustrationavatar-vector-icon-vector-id1208175274?k=20&m=1208175274&s=612x612&w=0&h=Ud2p5iidw5UDWGrzyuSiQ8eO08qzoqv_BAxnwx9qf1A=',
    username: 'Yolanda',
    timeAgo: '40m',
    text: 'Need a new washing machine! Anyone have contacts?',
    title: 'Washing Machine',
    comments: '10',
  ),
  const Post(
    dp: 'https://media.istockphoto.com/vectors/avatar-vector-icon-simple-element-illustrationavatar-vector-icon-vector-id1208175274?k=20&m=1208175274&s=612x612&w=0&h=Ud2p5iidw5UDWGrzyuSiQ8eO08qzoqv_BAxnwx9qf1A=',
    username: 'Trisha',
    timeAgo: '1h',
    text: 'Giving out a free airfryer',
    title: 'Airfryer',
    comments: '1K',
  ),
];

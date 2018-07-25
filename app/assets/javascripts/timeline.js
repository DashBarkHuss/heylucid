
// centerY = document.getElementById('timeline').getElementsByTagName('svg')[0].getBoundingClientRect().height/2;
// console.log(centerY);
// var svg1= "<svg height=\"100%\" width=\"100%\">\r\n  <line x1=\"10%\" y1=\"50%\" x2=\"90%\" y2=\"50%\" style=\"stroke:hotpink ;stroke-width:2\" \/>\r\n"
// var svg2="Sorry, your browser does not support inline SVG.\r\n<\/svg>"



// var circles = "";
// var segmentGroup;
// var circleGroup;

// function displayTimes(){
//   var sumOfTimeBefore = 0;
//       for (i=0; i<rcs.length; i++){

//               pos = (((rcs[i]+sumOfTimeBefore )/endTime)*80 + 10);
//               console.log(pos)


//               if (i!=0) {
//                 segments(lastPos, pos, i);
//               }

//               var color = "hotpink";

//               if (i!=0 && i!= rcs.length-1) {
//                color = pickColor(i);
//               }

//               var circleSVG1="<circle cx=\""
//               var circleSVG2="%\" cy=\"50%\" stroke=\""+color+"\"    fill=\""+ color+"\" \/>"

//               var circleSVG1Now="<circle class=\"now\" cx=\""
//               var circleSVG2Now = "%\" cy=\"50%\" \/>"

//               if (i+1 != rcs.length){
//                 circleGroup += circleSVG1 + pos +circleSVG2;
//               } else {
//                 circleGroup += circleSVG1Now + pos +circleSVG2Now;
//               }

//               addToolTips(pos, i);

//               sumOfTimeBefore += rcs[i]; 
//               lastPos = pos;
//             } 
  
//         function pickColor(i){
//           var score = rcs[i];
//         if (score >=4000) {
//           color = "#004d00";
//         } else if (score > 600 && score < 4000 ){
//           color = "#008000";
//         } else if (score <= 600) {
//           color =  "#80ff80";
//         }
//           return color
//         }
  
//       function segments(start, end, i){
//         var segment1 = "<line x1=\"";
//         var segment2="%\" y1=\"50%\" x2=\"";
//         var color = pickColor(i);
//         var segment3="%\" y2=\"50%\" style=\"stroke:"+ color + ";stroke-width:4\" \/>";

//         var segment = segment1 + start + segment2 +end + segment3; 
//         segmentGroup+= segment;
//       }

//       function addToolTips(position, i){
//         var toolTip1 = "<g class=\"tooltip css\" transform=\"translate("
//         var toolTip2=","  +centerY+ ")\">\r\n        <rect x=\"-3em\" y=\"-48\" width=\"6em\" height=\"1.25em\" rx=\"1%\" ry=\"1%\"\/>\r\n          <text y=\"-48\" dy=\"1em\" text-anchor=\"middle\" fill=\"black\"> \r\n"
//         var toolTip3="<\/text>\r\n  <\/g>";

//         var svgWidth= document.getElementsByTagName('svg')[0].getBoundingClientRect().width; //make sure it's the right index if you have multiple svgs

//         position = (position/100) * svgWidth;

//         circleGroup += toolTip1+position+toolTip2 + moment(timesOfRcs[i].date).format('LT')+toolTip3;
//       }
  
//   circles += segmentGroup + circleGroup;
//   //change from circles to segments and circles or something
//   return circles;
// }

  


// var html = svg1 +displayTimes()+svg2;
// document.getElementById('timeline').innerHTML = html;

// console.log(html);






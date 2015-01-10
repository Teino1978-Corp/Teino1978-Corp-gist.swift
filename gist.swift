        for var i = 0, elements = 0; i < circles; i++ {
            x = helixRadius * cos(t)
            z = helixRadius * sin(t)
            y = pitchInherent * pitchCurrent * t
            t += yIncrement
            
            helixAngle = atan2(x, z)
            
            let circleCenter = Float3(x: x, y: y, z: z)
            
            if i % 10 == 0 {
                let angleZenith: Float =  0 * Float(M_PI) / 180
                let angleInitial: Float = 90
                let angleAzimuth: Float = helixAngle + angleInitial * Float(M_PI) / 180
                
                let n = Float3(
                    x: cos(angleZenith) * sin(angleAzimuth),
                    y: sin(angleAzimuth) * sin(angleZenith),
                    z: cos(angleAzimuth))
                let u = Float3(
                    x: -sin(angleZenith),
                    y: cos(angleZenith),
                    z: 0)
                let nxu = Float3(
                    x: cos(angleAzimuth) * cos(angleZenith),
                    y: cos(angleAzimuth) * sin(angleZenith),
                    z: -sin(angleAzimuth))
                
                var circleSegment: Float = 0
                for var j = 0; j < circleSegments; j++, elements++ {
                    let circleX: Float = circleRadius * cos(circleSegment)
                    let circleY: Float = circleRadius * sin(circleSegment)
                    
                    let circleCoordinates = Float3(x: circleX, y: circleY, z: 0)
                    
                    let part1 = u.factor(circleCoordinates.x)
                    let part2 = nxu.factor(circleCoordinates.y)
                    
                    let circleParameter = part1.add(part2).add(circleCenter)
                    //normalArray += [circleParameter]
                    
                    vertexArray.setVertex(circleParameter, x: j, y: circleNumber)
                    circleSegment += Float(2*M_PI) / Float(circleSegments)
                    //println("(\(j), \(circleNumber)) -> \(circleParameter)")
                }
                circleNumber++
            }
        }

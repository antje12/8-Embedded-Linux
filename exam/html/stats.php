<!DOCTYPE html>
<html>
  <head>
    <title>EMLI Group 17</title>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
  <meta name="apple-mobile-web-app-capable" content="yes">
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        canvas {
            width: 400px !important;
            height: 200px !important;
        }
        .graph-container{
          width: 410px;
          border: 1px solid rgba(0,0,0,0.2);
          display: flex;
          flex-direction: column;
          align-items: center;
          margin: 5px;
        }
        .graph-wrapper{
          width: 100%;
          display:flex;
          flex-wrap:wrap;
          justify-content: center;
        }
        body{
          width: 100%;
          display: flex;
          flex-direction: column;
          justify-content: center;
          align-items: center;
          margin: 0;
          padding: 0;
        }
    </style>
</head>
<body>
<h1>Raspberry Pi - Health Stats and Downloads - EMLI Group 17</h1>
<!-- Graphs -->
<div class="graph-wrapper">
  <div class="graph-container">
  <p>Soil Moisture</p>
  <canvas id="soil_moisture"></canvas>
  <a class="button" href="download.php?file=soil_moisture.txt" download>Download ⬇️</a>
</div>

<div class="graph-container">
<p>Plant Water Alarm</p>
  <canvas id="plant_water_alarm"></canvas>
  <a class="button" href="download.php?file=plant_water_alarm.txt" download>Download ⬇️</a>
</div>

<div class="graph-container">
<p>Pump Water Alarm</p>
  <canvas id="pump_water_alarm"></canvas>
  <a class="button" href="download.php?file=pump_water_alarm.txt" download>Download ⬇️</a>
</div>

<div class="graph-container">
<p>Ambient Light</p>
  <canvas id="light"></canvas>
  <a class="button" href="download.php?file=light.txt" download>Download ⬇️</a>
</div>

<div class="graph-container">
<p>Pump Activations</p>
  <canvas id="pump_activations"></canvas>
  <a class="button" href="download.php?file=pump_activations.txt" download>Download ⬇️</a>
</div>
</div>

<script>
    var links = document.querySelectorAll('a.button');

    // Add styling to links
    for (var i = 0; i < links.length; i++) {
        links[i].style.display = 'inline-block';
        links[i].style.padding = '10px 20px';
        links[i].style.backgroundColor = '#007bff';
        links[i].style.color = '#fff';
        links[i].style.textDecoration = 'none';
        links[i].style.borderRadius = '5px';
        links[i].style.marginBottom = '10px';
    }

    // Add hover styling to links
    for (var i = 0; i < links.length; i++) {
        links[i].addEventListener('mouseover', function() {
            this.style.backgroundColor = '#0056b3';
        });

        links[i].addEventListener('mouseout', function() {
            this.style.backgroundColor = '#007bff';
        });
    }

      var timestamps = <?php echo json_encode($timestamps); ?>;
            var values = <?php echo json_encode($values); ?>;

            var ctx = document.getElementById('<?php echo $canvasId; ?>').getContext('2d');
            var myChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: timestamps,
                    datasets: [{
                        label: '<?php echo $canvasName; ?>',
                        data: values,
                        borderColor: 'rgb(75, 192, 192)',
                        tension: 0.1
                    }]
                }
            });

    // SOIL
</script>

<?php
    function drawGraph($canvasId, $canvasName, $filePath) {
        $data = file($filePath);

        $timestamps = [];
        $values = [];

        foreach ($data as $line) {
            $parts = explode(',', $line);
            $timestamp = trim($parts[0]);
            $value = trim($parts[1]);

            $timestamps[] = $timestamp;
            $values[] = $value;
        }
        ?>

        <script>
            var timestamps = <?php echo json_encode($timestamps); ?>;
            var values = <?php echo json_encode($values); ?>;

            var ctx = document.getElementById('<?php echo $canvasId; ?>').getContext('2d');
            var myChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: timestamps,
                    datasets: [{
                        label: '<?php echo $canvasName; ?>',
                        data: values,
                        borderColor: 'rgb(75, 192, 192)',
                        tension: 0.1
                    }]
                }
            });
        </script>
    <?php
    }

    drawGraph('soil_moisture', 'soil moisture', '/home/pi/scripts/exam/logs/soil_moisture.txt');
    drawGraph('pump_water_alarm', 'pump alarm', '/home/pi/scripts/exam/logs/pump_water_alarm.txt');
    drawGraph('plant_water_alarm', 'plant alarm', '/home/pi/scripts/exam/logs/plant_water_alarm.txt');
    drawGraph('pump_activations', 'pump activation', '/home/pi/scripts/exam/logs/pump_activations.txt');
    drawGraph('light', 'light', '/home/pi/scripts/exam/logs/light.txt');
    ?>
</body>
</html>

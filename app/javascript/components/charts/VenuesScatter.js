import React from "react"
import PropTypes from "prop-types"
import { Scatter } from "react-chartjs-2"

class VenuesScatter extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      isReady: false,
    }
  }

  componentDidMount () {
    fetch(this.props.path).
      then(response => response.json()).
      then((rows) => {
        this.setState({
          isReady: true,
          data: {
            datasets: [{
              data: rows.map((row) => { return { x: row.check_ins_count, y: row.rating } }),
              pointRadius: rows.map(row => (row.distinct_tagged_users_count + 1) * 2),
            }],
          },
          options: {
            tooltips: {
              mode: 'single',
              callbacks: {
                title: (point) => {
                  var row = rows[point[0].index];
                  return row.name + " (" + row.rating + ")";
                },
                label: (point) => {
                  var row = rows[point.index];
                  return row.check_ins_count + " check-ins";
                },
              },
            },
            legend: {
              display: false,
            },
            scales: {
              xAxes: [{
                display: false,
              }],
              yAxes: [{
                display: false,
              }],
            },
          },
        });
      });
  }

  render () {
    const { isReady, data, options } = this.state;

    if (isReady) {
      return (
        <Scatter data={data} options={options} />
      );
    }

    return (
      <p>Loading...</p>
    );
  }
}

VenuesScatter.propTypes = {
  path: PropTypes.string
};

export default VenuesScatter

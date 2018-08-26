import React from "react"
import PropTypes from "prop-types"
import { Pie } from "react-chartjs-2"

class CategoryPie extends React.Component {
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
          rows: rows,
        });
      });
  }

  getData() {
    const { rows } = this.state;

    return {
      datasets: [{
        data: rows.map(row => row.count),
      }],
      labels: rows.map(row => row.name),
    };
  }

  getOptions() {
    const { rows } = this.state;

    return {
      legend: {
        display: false,
      },
    };
  }

  render () {
    if (this.state.isReady) {
      return (
        <Pie data={this.getData()} options={this.getOptions()} />
      );
    }

    return (
      <p>Loading...</p>
    );
  }
}

CategoryPie.propTypes = {
  path: PropTypes.string
};

export default CategoryPie
